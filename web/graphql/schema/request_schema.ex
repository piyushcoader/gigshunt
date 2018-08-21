defmodule GigsHunt.Schema.Request do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo


  object :reply do
    field :id, :id
    field :text, :string
    field :user, :user, resolve: assoc(:user)
    field :request, :request, resolve: assoc(:request)
  end

  object :request do
    field :id, :id
    field :title, :string
    field :description, :string
    field :archived, :boolean
    field :price, :float
    field :delivery, :string
    field :sub_category, :sub_category, resolve: assoc(:sub_category)
    field :reply, list_of(:reply), resolve: assoc(:reply)
    field :user, :user, resolve: assoc(:user)
  end





  object :request_query do

    field :request_detail, :request do
      arg :id, non_null(:integer)

      resolve &GigsHunt.Resolver.Request.find_request/2
    end

    field :request_posted_by_user, list_of(:request) do
       resolve &GigsHunt.Resolver.Request.find_user_request/2
    end
  end

  object :request_mutation do

    field :create_request, :request do
      arg :description, :string
      arg :title, non_null(:string)
      arg :year, non_null(:integer)
      arg :month, non_null(:integer)
      arg :day, non_null(:integer)
      arg :hour, non_null(:integer)
      arg :minute, non_null(:integer)
      arg :price, non_null(:float)
      arg :sub_category, non_null(:integer)

      resolve &GigsHunt.Resolver.Request.create_request/2
    end

    field :update_request, :request do
      arg :description, :string
      arg :title, non_null(:string)
      arg :year, non_null(:integer)
      arg :month, non_null(:integer)
      arg :day, non_null(:integer)
      arg :hour, non_null(:integer)
      arg :minute, non_null(:integer)
      arg :price, non_null(:float)
      arg :sub_category, non_null(:integer)
      arg :request_id, non_null(:integer)
      resolve &GigsHunt.Resolver.Request.update_request/2
    end

    field :reply_to_request, :reply do
      arg :text, non_null(:string)
      arg :request_id, non_null(:integer)

      resolve &GigsHunt.Resolver.Request.create_reply/2
    end
  end
end
