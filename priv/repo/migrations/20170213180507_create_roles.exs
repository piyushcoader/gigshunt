defmodule GigsHunt.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:role) do
      add :type, :string

      timestamps()
    end

  end
end
