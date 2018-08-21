defmodule GigsHunt.Rating do
  use GigsHunt.Web, :model

  schema "rating" do
    field :buyer_rating_detail, :map
    field :buyer_rating_total, :float
    field :seller_rating_detail, :map
    field :seller_rating_total, :float
    field :buyer_comment, :string
    field :seller_comment, :string
    belongs_to :gigs, GigsHunt.Gigs

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:buyer_rating_detail, :buyer_rating_total, :seller_rating_detail, :seller_rating_total, :buyer_comment, :seller_comment])
    |> validate_required([:buyer_rating_detail, :buyer_rating_total, :seller_rating_detail, :seller_rating_total, :buyer_comment, :seller_comment])
  end
end
