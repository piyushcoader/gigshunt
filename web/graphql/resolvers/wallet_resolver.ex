defmodule GigsHunt.Resolver.Wallet do
  alias GigsHunt.Repo
  alias GigsHunt.Wallets

  # private functions

  @doc """
    create Wallet for user
  """
  defp create_wallet(wallet_params, user_id) do
    wallet_changeset= Wallets.changeset(%Wallets{user_id: user_id}, wallet_params)
    case Repo.insert(wallet_changeset) do
      {:ok, wallet_info} ->
        {:ok, wallet_info}

      {:error, error_changeset} ->
        {:error, %{message: "Oops! couldn't Create Wallet"}}
    end
  end

  @doc """
    update wallet Address For user
  """
  defp update_wallet(wallet_params, wallet_schema) do
    wallet_changeset = Wallets.changeset(wallet_schema, wallet_params)
    case Repo.update(wallet_changeset) do
      {:ok, updated_wallet} ->
        {:ok, updated_wallet}

      {:error, error_changeset} ->
        {:error, %{message: "Oops! couldn't update Wallet"}}
    end
  end
  @doc """
    fetch current logged in user wallet
  """
  def fetch_wallet(_params, %{context: %{current_user: user}}) do
    wallet_data = Repo.get_by(Wallets, user_id: user.id)
    {:ok, wallet_data}
  end

  @doc """
    return Error if user is not logged in
  """
  def fetch_wallet(_params, _info) do
    {:error, %{message: "oops user not logged in"}}

  end

  @doc """
    create or update user wallet
  """
  def manage_wallet(%{btc: btc}, %{context: %{current_user: user}}) do
    wallet_data = Repo.get_by(Wallets, user_id: user.id)
    wallet_params= %{btc: btc}
    case wallet_data do
      nil ->
        create_wallet(wallet_params, user.id)

      _ ->
        update_wallet(wallet_params, wallet_data)
    end
  end

  @doc """
   throw error if user is not logged in and trying to manage wallet
  """
  def manage_wallet(_params, _info)do
    {:error, %{message: "oops user not logged in"}}
  end
end
