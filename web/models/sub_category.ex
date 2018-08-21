defmodule GigsHunt.SubCategory do
  use GigsHunt.Web, :model

  schema "sub_category" do
    field :title, :string
    field :verified?, :boolean, default: false
    belongs_to :category, GigsHunt.Category

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :verified?])
    |> validate_required([:title, :verified?])
  end
end
