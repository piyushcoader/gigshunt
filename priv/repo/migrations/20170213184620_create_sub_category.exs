defmodule GigsHunt.Repo.Migrations.CreateSubCategory do
  use Ecto.Migration

  def change do
    create table(:sub_category) do
      add :title, :string
      add :verified?, :boolean, default: false, null: false
      add :category_id, references(:category, on_delete: :nothing)

      timestamps()
    end
    create index(:sub_category, [:category_id])
    unique_index(:sub_category, [:title])

  end
end
