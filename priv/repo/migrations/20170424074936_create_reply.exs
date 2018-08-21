defmodule GigsHunt.Repo.Migrations.CreateReply do
  use Ecto.Migration

  def change do
    create table(:reply) do
      add :text, :string
      add :request_id, references(:request, on_delete: :nothing)
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end
    create index(:reply, [:request_id])
    create index(:reply, [:user_id])

  end
end
