defmodule GigsHunt.Repo.Migrations.CreatePackage do
  use Ecto.Migration

  def change do
    create table(:package) do
      add :price, :float
      add :revision, :integer
      add :title, :string
      add :description, :text
      add :delivery_time, :integer
      add :delivery_type, :string
      add :gigs_id, references(:gigs, on_delete: :nothing)

      timestamps()
    end
    create index(:package, [:gigs_id])

  end
end
