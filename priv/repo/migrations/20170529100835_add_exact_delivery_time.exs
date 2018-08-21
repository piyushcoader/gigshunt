defmodule GigsHunt.Repo.Migrations.AddExactDeliveryTime do
  use Ecto.Migration

  def change do
    alter table(:gigs) do
      add :exact_delivery_time, :float
    end
  end
end
