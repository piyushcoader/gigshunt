defmodule GigsHunt.Wallets do
  use GigsHunt.Web, :model

  schema "wallets" do
    field :btc, :string
    belongs_to :user, GigsHunt.Users

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:btc])
    |> validate_required([:btc])
  end
end
