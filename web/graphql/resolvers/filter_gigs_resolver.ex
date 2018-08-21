defmodule GigsHunt.Resolver.Gigs.Filter do
  alias GigsHunt.Repo
  alias GigsHunt.Gigs

  def filter_gigs(%{filter_args: filter_args}, _info) do
     query = GigsHunt.Gigs.get_filter_query(filter_args)
     IO.inspect query
     {:ok, Repo.all(query)}
  end

end
