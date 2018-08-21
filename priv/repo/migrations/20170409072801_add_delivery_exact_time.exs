defmodule GigsHunt.Repo.Migrations.AddDeliveryExactTime do
  use Ecto.Migration

  def change do
    alter table(:package) do
      add :exact_delivery_time, :integer
    end
  end
end
