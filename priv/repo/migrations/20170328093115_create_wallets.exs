defmodule GigsHunt.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :BTC, :string
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end
    create index(:wallets, [:user_id])

  end
end
