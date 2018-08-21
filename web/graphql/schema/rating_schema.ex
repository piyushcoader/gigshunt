defmodule GigsHunt.Schema.Rating do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo

  object :rating_detail do
    field :communication, :float
    field :service, :float
    field :recommendation, :float
  end
  
  object :rating do
    field :id, :id
    field :buyer_rating_detail, :rating_detail
    field :buyer_rating_total, :float
    field :seller_rating_detail, :rating_detail
    field :seller_rating_total, :float
    field :buyer_comment, :string
    field :seller_comment, :string
    field :gigs, list_of(:gigs), resolve: assoc(:gigs)
  end
end
