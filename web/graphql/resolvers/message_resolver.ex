defmodule GigsHunt.Resolver.Message do
  alias GigsHunt.Repo
  alias GigsHunt.MessageMetadata
  import Ecto.Query, only: [from: 2]

  defp format_message_metadata(metadata, user) do
    formated_metadata =
      for message_metadata <- metadata do
      query = from m in GigsHunt.Message,
              where: m.message_metadata_id == ^message_metadata.id,
              select: m,
              limit: 1,
              order_by: [ desc: :id]

      message_data= Repo.one(query)


      last_message=
        if(message_data == nil ) do
          ''
        else
          message_data.text
        end

      user_info  =
        if(message_metadata.user1_id == user.id) do
          user_info_data= Repo.get(GigsHunt.Users, message_metadata.user2_id)

          user_info_data.profile
        else
          user_info_data= Repo.get(GigsHunt.Users, message_metadata.user1_id)

          user_info_data.profile
        end

        %{id: message_metadata.id, last_message: last_message, room_info: user_info }
    end
    IO.inspect formated_metadata
    formated_metadata
  end

  def find_message_metadata(_params, %{context: %{current_user: user}}) do
    query = from m in MessageMetadata,
            where: m.user1_id == ^user.id or m.user2_id == ^user.id,
            select: m,
            limit: 20

    message_metadata = Repo.all(query)

    {:ok, format_message_metadata(message_metadata, user)}
  end

  def create_message_metadata(%{user2: user2, room_name: room_name} = params, %{context: %{current_user: user}}) do
     metadata_changeset = MessageMetadata.changeset(%MessageMetadata{user1_id: user.id, user2_id: user2}, params)
     case Repo.insert(metadata_changeset) do
        {:ok, message_metadata} ->
          {:ok, message_metadata}

        {:error, error_changeset} ->
          IO.inspect error_changeset
          {:error, %{message: "oops Couldn't insert metadata"}}
     end
  end
end
