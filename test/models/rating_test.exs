defmodule GigsHunt.RatingTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Rating

  @valid_attrs %{buyer_comment: "some content", buyer_rating_detail: %{}, buyer_rating_total: "120.5", seller_comment: "some content", seller_rating_detail: %{}, seller_rating_total: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Rating.changeset(%Rating{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Rating.changeset(%Rating{}, @invalid_attrs)
    refute changeset.valid?
  end
end
