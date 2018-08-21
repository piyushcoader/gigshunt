defmodule GigsHunt.Repo.Migrations.CreateGigs do
  use Ecto.Migration

  def change do
    create table(:gigs) do
      add :title, :string
      add :links, :map
      add :verified?, :boolean, default: false, null: false
      add :description, :text
      add :slug_url, :string
      add :sub_category_id, references(:sub_category, on_delete: :nothing)
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end
    create index(:gigs, [:sub_category_id])
    create index(:gigs, [:user_id])

  end
end
