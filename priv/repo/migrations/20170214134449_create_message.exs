defmodule GigsHunt.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:message) do
      add :text, :string
      add :isFile?, :boolean, default: false, null: false
      add :message_metadata_id, references(:message_metadata, on_delete: :nothing)
      add :from, references(:user, on_delete: :nothing)
      add :to, references(:user, on_delete: :nothing)

      timestamps()
    end
    create index(:message, [:message_metadata_id])
    create index(:message, [:from])
    create index(:message, [:to])

  end
end
