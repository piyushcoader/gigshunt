defmodule GigsHunt.Resolver.Rating do
  alias GigsHunt.Repo
  alias GigsHunt.Rating
  alias GigsHunt.Gigs

  defp calculate_rating_total(%{communication: communication, service: service, recommendation: recomend})do
     (communication+service+recomend)/3
  end
  
  @doc """
    Rating by seller function
  """
  def rate_seller(%{buyer_rating_detail: buyer_rating_args, buyer_text: buyer_text}, _info) do

  end
end
