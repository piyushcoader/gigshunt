defmodule GigsHunt.RequestTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Request

  @valid_attrs %{archived: true, delivery: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, price: "120.5", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Request.changeset(%Request{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Request.changeset(%Request{}, @invalid_attrs)
    refute changeset.valid?
  end
end
