defmodule GigsHunt.Resolver.User do

  alias GigsHunt.Repo
  alias GigsHunt.Users

  defp update_user_password(password, user) do
    update_changeset = Users.update_password_changeset(user, %{password: password})
    case Repo.update(update_changeset) do
      {:ok, updated_changeset} ->

        {:ok, jwt, _ } = Guardian.encode_and_sign(user, :access)
        {:ok, %{token: jwt, user_info: user}}

      {:error, error_changeset} ->
        {:error, %{message: "couldn't update password"}}
    end
  end
  @doc """
    get user info
  """
  def user_info(%{id: id}, _context) do

    {:ok, Repo.get(Users, id)}
  end

  @doc """
    fetch current user info if logged in
  """
  def current_user(_params, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  @doc """
    send error if current user is not logged in
  """
  def current_user(_params, _info) do
    {:error, %{message: "user not logged in "}}
  end

  @doc """
    check login and generate token
  """
  defp check_login(params) do
    with {:ok, user} <- GigsHunt.Session.authenticate(params, Repo),
        {:ok, jwt, _ } <- Guardian.encode_and_sign(user, :access) do
         {:ok, %{token: jwt, user_info: user}}
    end
  end

  @doc """
    signup new user
  """
  def signup(user_params, _info) do

    role_info = Repo.get_by(GigsHunt.Roles, type: "unverified")
    user_changeset= Users.registration_changeset(%Users{role_id: role_info.id}, user_params)

    case Repo.insert(user_changeset) do
      {:ok, user} ->
        {:ok, jwt, _ } = Guardian.encode_and_sign(user, :access)

        {:ok, %{token: jwt, user_info: user}}

      {:error, changeset} ->
        {:error, changeset}

      _ ->
        {:error, %{message: "unknown Error occured"}}

      end
  end

  @doc """
    login user
  """
  def login(params, _info) do
    check_login(params)
  end

  @doc """
    check login credential
  """
  def check_login(_param, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  @doc """
    throw error if user is not logged in
  """
  def check_login(_params, _user)do
    {:error, %{message: "Invalid Token"}}
  end

  @doc """
    update profile if user is logged in
  """
  def update_profile(profile_params, %{context: %{current_user: user}}) do
    user_profile_changeset = Users.changeset(user,%{profile: profile_params})
    case Repo.update(user_profile_changeset) do
      {:ok, updated_user} ->
        {:ok, updated_user}

      {:error, changeset} ->
        {:error, %{message: "something went wrong couldn't update profile"}}
    end
  end
  @doc """
    throw error if user is not logged in and trying to update profile
  """
  def update_profile(profile_params, _info) do
    {:error, %{message: "User not logged in "}}
  end

  @doc """
    check if conf password and new password are same
  """
  def change_password(%{old_password: old_pass, new_password: new_pass, confirm_password: conf_pass}, %{context: %{current_user: user}}) when new_pass !== conf_pass , do: {:error, %{message: "New password and confirm password are not equal"}}

  @doc """
    change password resolver
  """
  def change_password(%{old_password: old_pass, new_password: new_pass, confirm_password: confirm_pass}, %{context: %{current_user: user}}) do
    if(String.length(new_pass)<6) do
      {:error, %{message: "Password must be atleast 6 letters"}}
    else
      case  GigsHunt.Session.authenticate(%{email: user.email, password: old_pass}, Repo) do
        {:ok, user} ->
          update_user_password(new_pass, user)

        {:error, reason}  ->
          {:error, %{message: "Incorrect Old Password"}}
      end
    end
  end


  @doc """
    check user is logged in or not
  """
  def change_password(_params, _info) do
    {:error, %{message: "Please Login to update Password"}}
  end
end
