defmodule GigsHunt.Repo.Migrations.AddColumnArchived do
  use Ecto.Migration

  def change do
    alter table(:gigs) do
      add :archived, :boolean
    end
  end
end
