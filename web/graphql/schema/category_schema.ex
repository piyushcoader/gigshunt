defmodule GigsHunt.Schema.Category do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo


  #schema for Category
  object :category do
    field :id, :id
    field :title, :string
    field :verified, :boolean
    field :sub_category, list_of(:sub_category), resolve: assoc(:sub_category)
  end

  # schema for sub_category
  object :sub_category do
    field :id, :id
    field :title, :string
    field :verified, :boolean
    field :category, :category, resolve: assoc(:category)
  end

  # Queries For Category
  object :category_query do
    field :all_category, list_of(:category) do
      resolve &GigsHunt.Resolver.Category.all_category/2
    end
  end

  object :sub_category_query do
    field :all_sub_category, list_of(:sub_category) do
      resolve &GigsHunt.Resolver.Category.all_sub_category/2
    end
  end


end
