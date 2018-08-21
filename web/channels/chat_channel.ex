defmodule GigsHunt.Channel.Message do
  use Phoenix.Channel
  alias GigsHunt.Repo
  alias GigsHunt.Message
  import Ecto.Query, only: [from: 2]

  @doc """
    function that joines channel between user and message
  """
  def join("message:" <> id, _params, %Phoenix.Socket{assigns: %{current_user: user}} = socket) do
    cond do
      String.to_integer(id) == user.id ->
        {:ok,  %{rooms: fetch_rooms(user) }, socket}
      true ->
        {:error, :invalid_id}
    end
  end

  def join(_room, _params, _socket) do
    {:error, :invalid_id}
  end

  @doc """
    handle fetching previous message data
  """
  def handle_in("fetch:message", %{"room_name" => room_name} = message_params, %Phoenix.Socket{assigns: %{current_user: user}} =socket) do
    room_info = Repo.get_by(GigsHunt.MessageMetadata, room_name: room_name)
    case room_info do
      nil ->
        {:reply, {:error, %{error: "Invalid room!"}}, socket}

      room ->
        IO.inspect fetch_message_info(room.id, message_params["offset_message"] || nil)
        IO.puts "------------------------------------------------------------------------"
        {:reply, {:ok, %{"messages" => fetch_message_info(room.id, message_params["offset_message"] || nil)}}, socket}
    end
  end

  @doc """
    function that handles sending message to other user channel
  """
  def handle_in("send:message", %{"text"=> message, "room_name" => room_name} = msg_params, %Phoenix.Socket{assigns: %{current_user: user}} =socket) do

    case Repo.get_by(GigsHunt.MessageMetadata, room_name: room_name) do
      nil ->
         {:reply, {:error, %{error: "Invalid Room name"}}, socket}

      room_info ->
        to = if room_info.user1_id == user.id , do: room_info.user2_id, else: room_info.user1_id

        msg_params = %{from: user.id, to: to, text: message, room_id: room_info.id}

        case insert_message(msg_params) do
          {:ok, message} ->
            msg_payload = %{"text" => message.text, "id" => message.id, "room_name" => room_info.room_name, "from" => user.id, "to" => to}
            GigsHunt.Endpoint.broadcast("message:#{to}", "receive:message", msg_payload)
            {:reply, {:ok, %{data: msg_payload}}, socket}

          {:error, _changeset } ->
            {:reply, {:error, %{error: "Error Sending Message try again !"}}, socket}
        end
    end
  end

  @doc """
    handle when user trying to create new room
  """
  def handle_in("create:room", %{"room_name" => room_name, "to_user" => to_user} = room_params, %Phoenix.Socket{assigns: %{current_user: user}} =socket) do
    user2_detail = Repo.get(GigsHunt.Users, to_user)

    query = from r in GigsHunt.MessageMetadata,
            where: (r.user1_id == ^to_user or r.user2_id == ^to_user) and (r.user1_id == ^user.id or r.user2_id == ^user.id),
            select: r

    message = Repo.one(query)
    cond do
      # if the other user is invalid
      user2_detail == nil ->
        IO.puts "USER IS INVALID"
        {:reply, {:error, %{message: "Invalid User"}, socket}}

      # if user already has session between them
      message != nil ->
        {:reply, {:error, %{message: "Room Already Created"}, socket}}

      # create room if user is valid and they have not started session
      true  ->
        room_changeset = GigsHunt.MessageMetadata.changeset(%GigsHunt.MessageMetadata{user1_id: user.id, user2_id: user2_detail.id}, room_params)
        with {:ok, room} <- Repo.insert(room_changeset),
             {:ok, msg} <- insert_message(%{from: user.id, to: user2_detail.id, room_id: room.id, text: room_params["text"] || "hi"})
        do
           # make data better to return back to client
           formated_room_info = format_new_created_room(room, user, user2_detail, room_params["text"] || "hi")
           GigsHunt.Endpoint.broadcast("message:#{to_user}", "room:invited", %{room: formated_room_info})
           {:reply, {:ok,  %{room: formated_room_info}}, socket}

         else
           {:error, error_changeset} ->
              IO.inspect error_changeset
              {:reply, {:error, %{message: "oops Couldn't create room"}}, socket}
        end
    end
  end

  # fetch room detail
  def fetch_rooms(user) do
    query = from r in GigsHunt.MessageMetadata,
            where: (r.user1_id == ^user.id or r.user2_id == ^user.id),
            order_by: [desc: :id],
            preload: [:user1, :user2],
            select: %{room: r, last_mesage: fragment("(SELECT  m1.text from message AS m1 WHERE message_metadata_id=? ORDER BY id DESC LIMIT 1)", r.id)}

      format_exact_room_data(Repo.all(query))
  end

  # if room is empty just return empty array
  defp format_exact_room_data([]), do: []

  # make room data preety if we have room info
  defp format_exact_room_data(data) do
    Enum.map(data, fn(result)->
      %{
        room_name: result.room.room_name,
        id: result.room.id,
        message: result.last_mesage,
        user1: %{id: result.room.user1.id, username: result.room.user1.username, profile: result.room.user1.profile},
        user2: %{id: result.room.user2.id, username: result.room.user2.username, profile: result.room.user2.profile}
      }
    end)
  end

  # format newly created room
  defp format_new_created_room(room_data, user1, user2, message) do
    %{
      room_name: room_data.room_name,
      id: room_data.id,
      message: message,
      user1: %{id: user1.id, username: user1.username, profile: user1.profile},
      user2: %{id: user2.id, username: user2.username, profile: user2.profile}
    }
  end

  # if fetching message for  first time
  defp fetch_message_info(roomId, nil) do
      query =
        from m in Message,
        where: m.message_metadata_id == ^roomId,
        limit: 100,
        select: %{from: m.from_id, to: m.to_id, text: m.text, id: m.id}

      Repo.all(query)
  end

  # fetching older message
  defp fetch_message_info(roomId, from_message) do
    query =
      from m in Message,
      where: m.message_metadata_id == ^roomId and m.id < ^from_message,
      limit: 20,
      select: %{from: m.from_id, to: m.to_id, text: m.text, id: m.id}

    x = Repo.all(query)
    IO.inspect x
    x
  end


  # insert message to database
  defp insert_message(%{from: from_id, to: to, text: text, room_id: room_id} = msg_params) do
    message_changeset = Message.changeset(%Message{from_id: from_id, to_id: to, message_metadata_id: room_id}, msg_params )
    Repo.insert(message_changeset);
  end
end
