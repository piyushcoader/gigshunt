defmodule GigsHunt.Repo.Migrations.AddOfferFieldInMessage do
  use Ecto.Migration

  def change do
    alter table(:message) do
      add :offer_id, references(:offer, on_delete: :nothing)
    end

    create index(:message, [:offer_id])
  end
end
