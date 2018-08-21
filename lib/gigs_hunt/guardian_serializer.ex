defmodule GigsHunt.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias GigsHunt.Repo
  alias GigsHunt.Users

  def for_token(user = %Users{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, Repo.get(Users, id) }
  def from_token(_), do: { :error, "Unknown resource type" }
end
