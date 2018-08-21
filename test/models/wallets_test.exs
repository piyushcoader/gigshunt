defmodule GigsHunt.WalletsTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Wallets

  @valid_attrs %{BTC: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Wallets.changeset(%Wallets{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Wallets.changeset(%Wallets{}, @invalid_attrs)
    refute changeset.valid?
  end
end
