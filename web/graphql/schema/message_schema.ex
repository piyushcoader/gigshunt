defmodule GigsHunt.Schema.Message do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo



  #schema for message
  object :message_metadata do
    field :id, :id
    field :room_info, :room_info
    field :last_message, :string
  end

  #schema for room info
  object :room_info do
    field :fname, :string do
      resolve fn room_info, _, _ -> {:ok, Map.get(room_info, "fname")} end
    end

    field :lname, :string do
      resolve fn room_info, _, _ -> {:ok, Map.get(room_info, "lname")} end
    end

    field :avatar, :string do
      resolve fn room_info, _, _ -> {:ok, Map.get(room_info, "avatar")} end
    end
  end

  object :single_metadata do
    field :id, :id
  end

  #query for message metadata
  object :metadata_query do
    field :metadata, list_of(:message_metadata) do
      resolve &GigsHunt.Resolver.Message.find_message_metadata/2
    end
  end

  #mutation for metadata
  object :metadata_mutation do
    field :create_metadata, :single_metadata do
      arg :user2, non_null(:integer)
      arg :room_name, non_null(:string)
      resolve &GigsHunt.Resolver.Message.create_message_metadata/2
    end
  end


end
