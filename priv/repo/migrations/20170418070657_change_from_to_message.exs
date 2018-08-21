defmodule GigsHunt.Repo.Migrations.ChangeFromToMessage do
  use Ecto.Migration

  def change do
    rename table(:message), :from, to: :from_id
    rename table(:message), :to, to: :to_id
  end
end
