defmodule GigsHunt.Repo.Migrations.CreateMessageMetadata do
  use Ecto.Migration

  def change do
    create table(:message_metadata) do
      add :room_name, :string
      add :archived?, :boolean, default: false, null: false
      add :user1, references(:user, on_delete: :nothing)
      add :user2, references(:user, on_delete: :nothing)

      timestamps()
    end
    create index(:message_metadata, [:user1])
    create index(:message_metadata, [:user2])

  end
end
