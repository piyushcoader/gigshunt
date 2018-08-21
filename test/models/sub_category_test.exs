defmodule GigsHunt.SubCategoryTest do
  use GigsHunt.ModelCase

  alias GigsHunt.SubCategory

  @valid_attrs %{title: "some content", verified?: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SubCategory.changeset(%SubCategory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SubCategory.changeset(%SubCategory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
