defmodule GigsHunt.Schema.User do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo

  @doc """
    User Schema Type
  """
  object :profile_obj do
    field :fname, :string do
      resolve fn profile, _, _ -> {:ok, profile[:fname] || Map.get(profile, "fname")} end
    end

    field :lname, :string do
      resolve fn profile, _, _ -> {:ok, profile[:lname] || Map.get(profile, "lname")} end
    end

    field :language, list_of(:string) do
      resolve fn profile, _, _ -> {:ok, profile[:language] || Map.get(profile, "language")} end
    end

    field :avatar, :string do
      resolve fn profile, _, _ -> {:ok, profile[:avatar] || Map.get(profile, "avatar")} end
    end

    field :bio, :string do
      resolve fn profile, _, _ -> {:ok, profile[:avatar] || Map.get(profile, "bio")} end
    end

  end


  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
    field :profile, :profile_obj
    field :role, :role, resolve: assoc(:role)
    field :gigs, list_of(:gigs), resolve: assoc(:gigs)
    field :wallet, :wallet, resolve: assoc(:wallet)
  end

  object :session do
    field :token, :string
    field :user_info, :user
  end



  @doc """
    Query For User Schema
  """
  object :user_query do
    field :user, :user do
      arg :id, non_null(:integer)
      resolve &GigsHunt.Resolver.User.user_info/2
    end

    field :current_user, :user do
      resolve &GigsHunt.Resolver.User.current_user/2
    end
  end

  @doc """
    Mutations For User Schema
  """
  object :user_mutation do

    field :signup, :session do
      arg :username, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &GigsHunt.Resolver.User.signup/2
    end

    field :user_login, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &GigsHunt.Resolver.User.login/2
    end

    field :check_login, :user do
      resolve &GigsHunt.Resolver.User.check_login/2
    end

    field :update_profile, :user do
      arg :fname, :string
      arg :lname, :string
      arg :language, list_of(:string)
      arg :avatar, :string
      arg :bio, :string

      resolve &GigsHunt.Resolver.User.update_profile/2
    end

    field :change_password, :session do
      arg :old_password, non_null(:string)
      arg :new_password, non_null(:string)
      arg :confirm_password, non_null(:string)

      resolve &GigsHunt.Resolver.User.change_password/2
    end

  end

end
