defmodule GigsHunt.Ledger do
  use GigsHunt.Web, :model

  schema "ledger" do
    field :pending?, :boolean, default: false
    field :cancelled?, :boolean, default: false
    field :deposited?, :boolean, default: false
    field :amount, :float
    belongs_to :to, GigsHunt.To
    belongs_to :from, GigsHunt.From
    belongs_to :offer, GigsHunt.Offer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:pending?, :cancelled?, :deposited?, :amount])
    |> validate_required([:pending?, :cancelled?, :deposited?, :amount])
  end
end
