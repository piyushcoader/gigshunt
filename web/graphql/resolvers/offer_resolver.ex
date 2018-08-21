defmodule GigsHunt.Resolver.Offer do
  alias GigsHunt.Offer
  alias GigsHunt.Repo
  import Ecto.Query

  defp insert_offer(offer_args, gigs_id, seller_id, buyer_id) do
    changeset = Offer.changeset(%Offer{gigs_id: gigs_id, buyer_id: buyer_id, seller_id: seller_id},offer_args);
    case Repo.insert(changeset) do
      {:ok, offer} ->
        {:ok, offer}

      {:error, error_changeset} ->
        IO.inspect error_changeset
        {:error, %{message: "Oops! couldn't create Offer"}}
    end
  end

  @doc """
    function to fetch offer with gigs supplied
  """
  def find_offer(%{offer_id: offer_id}, _info) do
    {:ok, Repo.get(Offer, offer_id)}
  end

  def find_offer(_parms, _info) do
    {:error, %{message: "invalid offer "}}
  end


  @doc """
    check buyer_id and seller id is same

  """
#  def create_offer(%{revision: revision, title: title, price: price, year: year, month: month, day: day, gigs_id: gigs_id,  buyer_id: buyer_id}= offer_args, %{context: %{current_user: user}})
#    when buyer_id === ,
#    do: {:error, %{message: "you cannot have same buyer and seller for offer"}}

  @doc """
   create new offer
  """
  def create_offer(offer_args, %{context: %{current_user: user}}) do

    %{revision: revision, title: title, price: price, year: year, description: description, month: month, day: day, gigs_id: gigs_id} = offer_args
    buyer_id =
      if(Map.has_key?(offer_args, :buyer_id)) do
        offer_args.buyer_id
      else
        nil
      end




    gigs = Repo.get_by(GigsHunt.Gigs, id: gigs_id, user_id: user.id)

    case gigs do
      nil ->
         {:error, %{message: "Invalid Gigs"}}

      _ ->
        parsed_offer_args_with_delivery =  Map.put(offer_args , :delivery_time, Ecto.DateTime.from_erl({{year, month, day}, {23, 0, 0 }}))
        insert_offer(parsed_offer_args_with_delivery, gigs.id,  gigs.user_id,  buyer_id)
    end
  end
  @doc """
    throw error if user is not logged in
  """
  def create_offer(_params, _info) do
    {:error, %{message: "please login to create Offer"}}
  end

  def find_user_offer(_params, %{context: %{current_user: user}}) do
    query = from o in Offer,
            where: o.buyer_id == ^user.id or o.seller_id == ^user.id,
            select: o
    {:ok, Repo.all(query)}

  end

  def find_user_offer(_params, _info) do
    {:error, %{message: "please login to view offers"}}
  end

  def accept_offer(%{offer_id: offer_id}, %{context: %{current_user: user}}) do
     offer = Repo.get(Offer, offer_id)
     cond do
        offer == nil ->
          {:error, %{message: "offer not found"}}

        offer.seller_id == user.id ->
          {:error, %{message: "you cannot accept the offer you create"}}

        true ->
          offer = Map.put(offer, :buyer_id, user.id)
          offer_changeset = Offer.changeset(offer, %{accepted: true})
          case Repo.update(offer_changeset) do
            {:ok, offer} ->
                {:ok, offer}

            {:error, _error_changeset} ->
              {:ok , %{message: "Couldnot create Offer"}}
          end
     end
  end

  def accept_offer(_params, _info) do
    {:error, %{message: "you need to login to accept offer"}}
  end

  def update_offer(%{revision: revision, title: title, offer_id: offer_id, price: price, year: year, description: description, month: month, day: day, gigs_id: gigs_id} = offer_args, %{context: %{current_user: user}}) do
    query = from o in Offer,
            join: g in GigsHunt.Gigs, on: g.id == o.gigs_id and o.seller_id == g.user_id,
            where: o.seller_id == ^user.id and o.id == ^offer_id and o.accepted == false and o.completed == false,
            select: o
    offer_detail = Repo.one(query)
    case offer_detail  do
      nil ->
        {:error, %{message: "invalid offer to update"}}

      offer ->
        offer = Map.put(offer, :gigs_id, gigs_id)
        parsed_offer_args_with_delivery =  Map.put(offer_args , :delivery_time, Ecto.DateTime.from_erl({{year, month, day}, {23, 0, 0 }}))
        offer_changeset = GigsHunt.Offer.changeset(offer, parsed_offer_args_with_delivery )
        case Repo.update(offer_changeset) do
          {:ok, offer} ->
            {:ok, offer}

          {:error, _offer_changeset} ->
            {:error, %{message: "couldn't create offer"}}
        end
    end
  end

  def update_offer(_params, _info) do
    {:error, %{message: "please login to update offer "}}
  end

end
