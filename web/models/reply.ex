defmodule GigsHunt.Reply do
  use GigsHunt.Web, :model

  schema "reply" do
    field :text, :string
    belongs_to :request, GigsHunt.Request
    belongs_to :user, GigsHunt.Users

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text])
    |> validate_required([:text])
  end
end
