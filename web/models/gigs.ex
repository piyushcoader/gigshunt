defmodule GigsHunt.Gigs do
  use GigsHunt.Web, :model
  import Ecto.Query, only: [from: 2]

  schema "gigs" do
    field :title, :string
    field :links, :map
    field :verified?, :boolean, default: false
    field :description, :string
    field :slug_url, :string
    field :archived, :boolean, default: false
    field :price, :float
    field :time_period, :integer
    field :time_unit, :string
    field :exact_delivery_time, :integer
    has_many :packages, GigsHunt.Package, foreign_key: :gigs_id
    has_many :rating, GigsHunt.Rating, foreign_key: :gigs_id
    belongs_to :sub_category, GigsHunt.SubCategory
    belongs_to :user, GigsHunt.Users

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :links, :verified?, :description, :slug_url, :archived, :price, :time_period, :time_unit])
    |> generate_slug_url()
    |> validate_required([:title, :links, :verified?, :description, :slug_url])
    |> add_delivery_period()
  end

  defp generate_slug_url(changeset) do

    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} ->
        put_change(changeset, :slug_url, String.replace(title, " ", "-") <> "-#{:rand.uniform(20)}")

      _ ->
        changeset
    end
  end

  defp add_delivery_period(changeset) do
     case changeset do
       %Ecto.Changeset{valid?: true, changes: %{delivery_time: d_time, delivery_type: d_type}} ->
         put_change(changeset, :exact_delivery_time, GigsHunt.Package.calculate_exact_delivery_time(d_type, d_time))

        _ ->
          changeset
     end
  end

  # Generate Queries
  def get_filter_query(filter_params) do
    query = from g in __MODULE__, limit: 20
    parsed_map =
      for  {k, v}  <- filter_params   do
        %{"#{k}" => v}
      end
    final_query = generate_query(parsed_map, query)

    from g in final_query, distinct: g.id
  end

  defp generate_query([], query), do: query

  defp generate_query([head | tail], query)do
    case head do
      %{"sub_category_id" => sub_category_id} ->
         new_query =
            from g in query,
            join: s in GigsHunt.SubCategory,
            on: g.sub_category_id == s.id,
             where:  s.id == ^sub_category_id

         generate_query(tail, new_query)


      %{"all_sub_category" => all_sub_category} ->
        new_query= from g in query, where: g.sub_category_id in ^all_sub_category
        generate_query(tail, new_query)

      %{"price" => %{max: max_price, min: min_price}} ->
         new_query=
           from g in query,
           where: g.price >= ^min_price and g.price <= ^max_price

         generate_query(tail, new_query)

      %{"delivery" => %{d_time: d_time, d_type: d_type}} ->
        exact_delivery_time = GigsHunt.Package.calculate_exact_delivery_time(d_type, d_time)
        new_query =
          from g in query,
          where: not is_nil(g.exact_delivery_time) and g.exact_delivery_time > 0  and g.exact_delivery_time <= ^exact_delivery_time

        generate_query(tail, new_query)

      %{"pagination_from" => from} ->
            new_query = from g in query, where: g.id > ^from

            generate_query(tail, new_query)

        _ ->
          generate_query(tail, query)
    end
  end
end
