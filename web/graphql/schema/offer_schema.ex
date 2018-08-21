defmodule GigsHunt.Schema.Offer do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo
    object :offer do
      field :id, :id
      field :revision, :integer
      field :title, :string
      field :price, :float
      field :completed, :boolean
      field :accepted, :boolean
	    field :description, :string
	    field :rating, :rating, resolve: assoc(:rating)
	    field :gigs, :gigs, resolve: assoc(:gigs)
	    field :buyer, :user, resolve: assoc(:buyer)
	    field :seller, :user, resolve: assoc(:seller)
	    field :delivery_time, :string
      field :inserted_at, :string
  end

  object :offer_query do
    field :offer_detail, :offer do
      arg :offer_id, non_null(:integer)
      resolve &GigsHunt.Resolver.Offer.find_offer/2
    end

    field :user_offers, list_of(:offer) do
      resolve &GigsHunt.Resolver.Offer.find_user_offer/2
    end

  end

  #offer mutation
  object :offer_mutation do
    field :create_offer, :offer do
      arg :revision, non_null(:integer)
      arg :description, :string
      arg :title, non_null(:string)
      arg :price, non_null(:float)
      arg :year, non_null(:integer)
      arg :month, non_null(:integer)
      arg :day, non_null(:integer)
      arg :gigs_id, non_null(:integer)
      arg :buyer_id, :integer
      resolve &GigsHunt.Resolver.Offer.create_offer/2
    end

    field :accept_offer, :offer do
       arg :offer_id, non_null(:integer)
       resolve &GigsHunt.Resolver.Offer.accept_offer/2
    end

    field :update_offer, :offer do
      arg :revision, non_null(:integer)
      arg :description, :string
      arg :title, non_null(:string)
      arg :price, non_null(:float)
      arg :year, non_null(:integer)
      arg :month, non_null(:integer)
      arg :day, non_null(:integer)
      arg :gigs_id, non_null(:integer)
      arg :offer_id, non_null(:integer)

      resolve &GigsHunt.Resolver.Offer.update_offer/2
    end
  end



end
