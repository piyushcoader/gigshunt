defmodule GigsHunt.LedgerTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Ledger

  @valid_attrs %{amount: "120.5", cancelled?: true, deposited?: true, pending?: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ledger.changeset(%Ledger{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ledger.changeset(%Ledger{}, @invalid_attrs)
    refute changeset.valid?
  end
end
