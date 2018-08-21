defmodule GigsHunt.MessageMetadata do
  use GigsHunt.Web, :model

  schema "message_metadata" do
    field :room_name, :string
    field :archived?, :boolean, default: false
    belongs_to :user1, GigsHunt.Users
    belongs_to :user2, GigsHunt.Users

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:room_name])
    |> validate_required([:room_name])
  end
end
