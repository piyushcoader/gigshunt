defmodule GigsHunt.Repo.Migrations.CreateRequest do
  use Ecto.Migration

  def change do
    create table(:request) do
      add :title, :string
      add :delivery, :datetime
      add :price, :float
      add :archived, :boolean, default: false, null: false
      add :sub_category_id, references(:sub_category, on_delete: :nothing)
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end
    create index(:request, [:sub_category_id])
    create index(:request, [:user_id])

  end
end
