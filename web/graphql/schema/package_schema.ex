defmodule GigsHunt.Schema.Package do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo

  @doc """
    Schema for package
  """
  object :package do
    field :id, :id
    field :price, :float
    field :title, :string
    field :description, :string
    field :delivery_time, :integer
    field :delivery_type, :string
    field :gigs, :gigs, resolve: assoc(:gigs)
  end
end
