defmodule GigsHunt.Package do
  use GigsHunt.Web, :model

  schema "package" do
    field :price, :float
    field :revision, :integer, default: 1
    field :title, :string
    field :description, :string
    field :delivery_time, :integer
    field :delivery_type, :string
    field :exact_delivery_time, :integer
    belongs_to :gigs, GigsHunt.Gigs

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:price, :revision, :title, :description, :delivery_time, :delivery_type])
    |> validate_required([:price, :revision, :title, :delivery_time, :delivery_type])
    |> add_delivery_period()
  end

  defp add_delivery_period(changeset) do
     case changeset do
       %Ecto.Changeset{valid?: true, changes: %{delivery_time: d_time, delivery_type: d_type}} ->
         put_change(changeset, :exact_delivery_time, calculate_exact_delivery_time(d_type, d_time))

        _ ->
          changeset
     end
  end

  def calculate_exact_delivery_time(d_type, value) do
    delivery_type_mapping = %{"year" => value * 8760, "months" => value * 720, "days" => value * 24, "hours" => value }

    if(delivery_type_mapping[d_type]) do
      delivery_type_mapping[d_type]
    else
      0
    end

  end
end
