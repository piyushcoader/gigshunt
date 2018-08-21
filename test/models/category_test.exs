defmodule GigsHunt.CategoryTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Category

  @valid_attrs %{title: "some content", verified?: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
  end
end
