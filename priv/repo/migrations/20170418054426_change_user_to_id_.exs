defmodule GigsHunt.Repo.Migrations.ChangeUserToId do
  use Ecto.Migration

  def change do
    rename table(:message_metadata), :user1, to: :user1_id
    rename table(:message_metadata), :user2, to: :user2_id
  end
end
