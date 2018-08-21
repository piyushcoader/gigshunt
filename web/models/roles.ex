defmodule GigsHunt.Roles do
  use GigsHunt.Web, :model

  schema "role" do
    field :type, :string
    has_many :user, GigsHunt.Users, foreign_key: :role_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type])
    |> validate_required([:type])
  end
end
