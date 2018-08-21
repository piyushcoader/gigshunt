defmodule GigsHunt.Schema.Wallet do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo

  object :wallet do
    field :id, :id
    field :btc, :string 
    field :user, :user, resolve: assoc(:user)
  end

  @doc """
    wallet query
  """
  object :wallet_query do

    field :user_wallet, :wallet do
      resolve &GigsHunt.Resolver.Wallet.fetch_wallet/2
    end

  end

  @doc """
    wallet mutation
  """
  object :wallet_mutation do

    field :manage_wallet, :wallet do

      arg :btc, :string
      resolve &GigsHunt.Resolver.Wallet.manage_wallet/2
    end
  end
end
