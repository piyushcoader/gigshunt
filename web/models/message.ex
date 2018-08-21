defmodule GigsHunt.Message do
  use GigsHunt.Web, :model

  schema "message" do
    field :text, :string
    field :isFile?, :boolean, default: false
    belongs_to :message_metadata, GigsHunt.MessageMetadata
    belongs_to :from, GigsHunt.From
    belongs_to :to, GigsHunt.To

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :isFile?])
    |> validate_required([:text, :isFile?])
  end
end
