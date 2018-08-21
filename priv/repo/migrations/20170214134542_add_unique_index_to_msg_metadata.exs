defmodule GigsHunt.Repo.Migrations.AddUniqueIndexToMsgMetadata do
  use Ecto.Migration

  def change do
    unique_index(:message_metadata, [:room_name])
  end
end
