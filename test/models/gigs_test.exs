defmodule GigsHunt.GigsTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Gigs

  @valid_attrs %{description: "some content", links: %{}, slug_url: "some content", title: "some content", verified?: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Gigs.changeset(%Gigs{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Gigs.changeset(%Gigs{}, @invalid_attrs)
    refute changeset.valid?
  end
end
