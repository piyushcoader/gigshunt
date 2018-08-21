defmodule GigsHunt.Repo.Migrations.AddPriceTimeToGigs do
  use Ecto.Migration

  def change do
    alter table(:gigs) do
      add :price, :float
      add :time_period, :integer
      add :time_unit, :string
    end
  end
end
