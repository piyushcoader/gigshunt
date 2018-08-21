defmodule GigsHunt.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:category) do
      add :title, :string
      add :verified?, :boolean, default: false, null: false

      timestamps()
    end

    unique_index(:category, [:title])

  end
end
