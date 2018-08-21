defmodule GigsHunt.MessageChannel do
  use Phoenix.Channel
  alias GigsHunt.Repo
  alias GigsHunt.Message
  import Ecto.Query, only: [from: 2]

  def join("message:" <> room_id, %{"msgId" => msgId}, %Phoenix.Socket{assigns: %{current_user: user}} =socket) do
    query = from m in GigsHunt.MessageMetadata,
            where: m.user1_id == ^user.id or m.user2_id == ^user.id,
            select: m,
            limit: 1

    parsed_room_id=String.to_integer(room_id)
    query = from m in query, where: m.id == ^parsed_room_id
    room_info = Repo.one(query)

    case room_info do
      nil ->
        {:error, :invalid_room}
      _ ->
        to = if room_info.user1_id == user.id, do: room_info.user2_id, else: room_info.user1_id

        message_query = from m in Message,
                        where: (m.from_id==^ user.id or m.to_id == ^user.id) and (m.from_id==^ to or m.to_id == ^to) and m.id > ^msgId,
                        select: %{text: m.text, from_id: m.from_id, to_id: m.to_id}

        previous_message = Repo.all(message_query)
        IO.inspect previous_message
        info = %{user1: room_info.user1_id, user2: room_info.user2_id, room_id: String.to_integer(room_id) }

        {:ok, %{all_message: previous_message}, assign(socket, :info, info)}
    end
  end

  def join("message:" <> _user_id, _params, _socket), do: {:error, :invalid}

  def handle_in("message:send", %{"tempId" => tempId, "text" => msgText}=msg_params,  %Phoenix.Socket{assigns: %{current_user: user, info: info}} =socket) do
    %{user1: user1, user2: user2, room_id: room_id} = info

    to = if user1 == user.id, do: user2, else: user1
    message_changeset = Message.changeset(%Message{from_id: user.id, to_id: to, message_metadata_id: room_id }, msg_params)
    case Repo.insert(message_changeset) do
      {:ok, message} ->
        IO.inspect message
        broadcast! socket, "message:received", %{from_id: message.from_id, to_id: message.to_id, text: msgText, tempId: tempId}
        {:noreply, socket}

      {:error, err_changeset} ->
        IO.inspect err_changeset
        {:reply, {:error, %{error: "Error Sending Message try again !"}}, socket}
    end
  end

end
