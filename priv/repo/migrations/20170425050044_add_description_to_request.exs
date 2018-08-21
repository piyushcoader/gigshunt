defmodule GigsHunt.Repo.Migrations.AddDescriptionToRequest do
  use Ecto.Migration

  def change do
    alter table(:request) do
      add :description, :text
    end
  end
end
