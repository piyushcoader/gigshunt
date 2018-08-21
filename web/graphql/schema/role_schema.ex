defmodule GigsHunt.Schema.Role do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo

  @doc """
    Schema For Roles
  """
  object :role do
    field :id, :id
    field :type, :string
    field :user, list_of(:user), resolve: assoc(:user)
  end

  @doc """
    Queries For Roles
  """
  object :role_query do
    field :all_role, list_of(:role) do
      resolve &GigsHunt.Resolver.Roles.all_roles/2
    end
  end


end
