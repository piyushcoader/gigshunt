defmodule GigsHunt.Resolver.Request do
  alias GigsHunt.Request
  alias GigsHunt.Repo
  alias GigsHunt.Reply
  import Ecto.Query, only: [from: 2]

  @doc """
    finding request detail
  """
  def find_request(%{id: id}, %{context: %{current_user: user}}) do
    query = from r in Request,
            where: r.id == ^id and r.user_id == ^user.id,
            select: r
    case Repo.one(query) do
      nil ->
        {:error, %{message: "oops! request not found"}}

      request ->
        {:ok, request}
    end
  end

  @doc """
    throwing error if user is not logged in or invalid params passed
  """
  def find_request(_params, _context) do
    {:error, %{message: "please login to post Request"}}
  end

  @doc """
    find all request of particular user
  """
  def find_user_request(_params, %{context: %{current_user: user}}) do
    query = from r in Request,
            where: r.user_id == ^user.id,
            select: r

    {:ok, Repo.all(query)}
  end

  @doc """
    throw error if user is not logged in and trying to access request
  """
  def find_user_request(_params, _context) do
     {:error, %{message: "user not logged in "}}
  end

  @doc """
    create request
  """
  def create_request(%{title: title, day: day, month: month, year: year, hour: hour, minute: minute, price: price, sub_category: sub_category}, %{context: %{current_user: user}}) do
    request_params= %{title: title, price: price, delivery: Ecto.DateTime.from_erl({{year, month, day}, {hour, minute, 0}})}
    request_changeset= Request.changeset(%Request{sub_category_id: sub_category, user_id: user.id}, request_params)

    case Repo.insert(request_changeset) do
      {:ok , request} ->
        {:ok, request}

      {:error, error_changeset} ->
        IO.inspect error_changeset
        {:error, %{message: "oops couldn't insert request"}}
    end
  end

  @doc """
    throw error if user is not logged in and trying to create request
  """
  def create_request(_params, _info) do
    {:error, %{message: "Please Login to create request"}}
  end

  @doc """
    Reply to request
  """
  def create_reply(%{text: text, description: description, request_id: request_id} = reply_params, %{context: %{current_user: user}}) do
    query = from r in Request,
            where: r.id == ^request_id and r.user_id != ^user.id,
            select: r

    case Repo.one(query) do
      nil ->
        {:error, %{message: "we cannot find task to reply for you "}}

      request ->
        reply_changeset = Reply.changeset(%Reply{user_id: user.id, request_id: request.id}, reply_params)
        Repo.insert(reply_changeset)
    end
  end

  @doc """
    throw error if user is not logged in and trying to reply
  """
  def create_reply(_params, _context) do
    {:error, %{message: "please login to post reply for task"}}
  end

  def update_request(%{request_id: r_id, title: title, day: day, month: month, year: year, hour: hour, minute: minute, price: price, sub_category: sub_category},%{context: %{current_user: user}}) do
    query = from r in Request,
            where: r.id == ^r_id and r.user_id == ^user.id,
            select: r
    case Repo.one(query) do
      nil ->
        {:error, %{message: "invalid request to update"}}

      request ->
        request_params= %{title: title, price: price, delivery: Ecto.DateTime.from_erl({{year, month, day}, {hour, minute, 0}})}
        request = Map.put(request, :sub_category_id, sub_category)
        IO.inspect request
          req_changeset =  Request.changeset(request, request_params)
          IO.inspect req_changeset
          case Repo.update(req_changeset) do
            {:ok, updated_request} ->

                {:ok, updated_request }

            {:error, _error_changeset} ->
                {:error, %{message: "oops couldn't update"}}
          end
    end

  end

  def update_request(_param, _info) do
    {:error, %{message: "please login to update"}};
  end
end
