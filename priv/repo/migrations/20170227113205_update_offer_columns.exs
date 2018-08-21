defmodule GigsHunt.Repo.Migrations.UpdateOfferColumns do
  use Ecto.Migration

  def change do
    rename table(:offer), :buyer, to: :buyer_id
    rename table(:offer), :seller, to: :seller_id
  end
end
