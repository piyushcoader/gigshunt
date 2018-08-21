defmodule GigsHunt.Resolver.Roles do
  alias GigsHunt.Repo
  alias GigsHunt.Roles

  def all_roles(_args, _info) do
    {:ok, Repo.all(Roles)}
  end
end
