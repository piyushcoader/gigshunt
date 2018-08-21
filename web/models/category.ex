defmodule GigsHunt.Category do
  use GigsHunt.Web, :model

  schema "category" do
    field :title, :string
    field :verified?, :boolean, default: false
    has_many :sub_category, GigsHunt.SubCategory
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :verified?])
    |> validate_required([:title])
  end
end
