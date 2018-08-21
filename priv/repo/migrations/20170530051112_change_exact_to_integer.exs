defmodule GigsHunt.Repo.Migrations.ChangeExactToInteger do
  use Ecto.Migration

  def change do
    alter table(:gigs) do
      modify :exact_delivery_time, :integer 
    end
  end
end
