defmodule GigsHunt.Resolver.Category do
  alias GigsHunt.Repo
  alias GigsHunt.Category
  alias GigsHunt.SubCategory

  def all_category(_args, _info) do
    {:ok, Repo.all(Category)}
  end

  def all_sub_category(_args, _info) do
    {:ok, Repo.all(SubCategory)}
  end
end
