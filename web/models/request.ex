defmodule GigsHunt.Request do
  use GigsHunt.Web, :model

  schema "request" do
    field :title, :string
    field :delivery, Ecto.DateTime
    field :price, :float
    field :description, :string
    field :archived, :boolean, default: false
    belongs_to :sub_category, GigsHunt.SubCategory
    belongs_to :user, GigsHunt.Users
    has_many :reply, GigsHunt.Reply
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :delivery, :price, :description])
    |> validate_required([:title, :delivery, :price])
  end
end
