defmodule GigsHunt.MessageMetadataTest do
  use GigsHunt.ModelCase

  alias GigsHunt.MessageMetadata

  @valid_attrs %{archived?: true, room_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MessageMetadata.changeset(%MessageMetadata{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MessageMetadata.changeset(%MessageMetadata{}, @invalid_attrs)
    refute changeset.valid?
  end
end
