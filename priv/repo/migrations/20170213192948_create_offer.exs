defmodule GigsHunt.Repo.Migrations.CreateOffer do
  use Ecto.Migration

  def change do
    create table(:offer) do
      add :revision, :integer
      add :title, :string
      add :price, :float
      add :completed?, :boolean, default: false, null: false
      add :accepted?, :boolean, default: false, null: false
      add :delivery_time, :naive_datetime
      add :buyer, references(:user, on_delete: :nothing)
      add :seller, references(:user, on_delete: :nothing)
      add :rating_id, references(:rating, on_delete: :nothing)
      add :gigs_id, references(:gigs, on_delete: :nothing)

      timestamps()
    end
    create index(:offer, [:buyer])
    create index(:offer, [:seller])
    create index(:offer, [:rating_id])
    create index(:offer, [:gigs_id])

  end
end
