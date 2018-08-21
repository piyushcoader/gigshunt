defmodule GigsHunt.Repo.Migrations.UpdateWalletColumnBtc do
  use Ecto.Migration

  def change do
    rename table(:wallets), :BTC, to: :btc
  end
end
