defmodule GigsHunt.Repo.Migrations.AddDescriptionToOffer do
  use Ecto.Migration

  def change do
    alter table(:offer) do
      add :description, :text
    end
  end
end
