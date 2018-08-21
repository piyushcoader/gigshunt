defmodule GigsHunt.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :username, :string
      add :email, :string
      add :enc_password, :string
      add :profile, :map
      add :role_id, references(:role, on_delete: :nothing)

      timestamps()
    end
    create index(:user, [:role_id])
    unique_index(:user, [:email])
    unique_index(:user, [:username])

  end
end
