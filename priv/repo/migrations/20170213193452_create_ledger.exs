defmodule GigsHunt.Repo.Migrations.CreateLedger do
  use Ecto.Migration

  def change do
    create table(:ledger) do
      add :pending?, :boolean, default: false, null: false
      add :cancelled?, :boolean, default: false, null: false
      add :deposited?, :boolean, default: false, null: false
      add :amount, :float
      add :to, references(:user, on_delete: :nothing)
      add :from, references(:user, on_delete: :nothing)
      add :offer_id, references(:offer, on_delete: :nothing)

      timestamps()
    end
    create index(:ledger, [:to])
    create index(:ledger, [:from])
    create index(:ledger, [:offer_id])

  end
end
