defmodule GigsHunt.PackageTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Package

  @valid_attrs %{delivery_time: 42, delivery_type: "some content", description: "some content", price: "120.5", revision: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Package.changeset(%Package{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Package.changeset(%Package{}, @invalid_attrs)
    refute changeset.valid?
  end
end
