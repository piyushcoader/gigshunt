defmodule GigsHunt.Repo.Migrations.ChangeOfferColumnName do
  use Ecto.Migration

  def change do
    rename table(:offer), :completed?, to: :completed
    rename table(:offer), :accepted?, to: :accepted
  end
end
