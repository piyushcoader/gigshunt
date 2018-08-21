defmodule GigsHunt.Offer do
  use GigsHunt.Web, :model

  schema "offer" do
    field :revision, :integer
    field :title, :string
    field :price, :float
    field :description, :string
    field :completed, :boolean, default: false
    field :accepted, :boolean, default: false
    field :delivery_time, Ecto.DateTime
    belongs_to :buyer, GigsHunt.Users, foreign_key: :buyer_id
    belongs_to :seller, GigsHunt.Users, foreign_key: :seller_id
    belongs_to :rating, GigsHunt.Rating, foreign_key: :rating_id
    belongs_to :gigs, GigsHunt.Gigs, foreign_key: :gigs_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:revision, :title, :price, :completed, :accepted, :delivery_time, :description])
    |> validate_required([:revision, :title, :price, :completed, :description, :accepted, :delivery_time])
  end
end
