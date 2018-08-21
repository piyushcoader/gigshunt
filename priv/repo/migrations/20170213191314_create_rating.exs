defmodule GigsHunt.Repo.Migrations.CreateRating do
  use Ecto.Migration

  def change do
    create table(:rating) do
      add :buyer_rating_detail, :map
      add :buyer_rating_total, :float
      add :seller_rating_detail, :map
      add :seller_rating_total, :float
      add :buyer_comment, :string
      add :seller_comment, :string
      add :gigs_id, references(:gigs, on_delete: :nothing)

      timestamps()
    end
    create index(:rating, [:gigs_id])

  end
end
