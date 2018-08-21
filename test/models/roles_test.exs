defmodule GigsHunt.RolesTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Roles

  @valid_attrs %{type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Roles.changeset(%Roles{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Roles.changeset(%Roles{}, @invalid_attrs)
    refute changeset.valid?
  end
end
