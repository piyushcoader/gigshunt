defmodule GigsHunt.Session do
  alias GigsHunt.Users

  def authenticate(params, repo) do
    user = repo.get_by(Users, email: String.downcase(params.email))
    case check_password(user, params.password) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.enc_password)
    end
  end
end
