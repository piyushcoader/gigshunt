defmodule GigsHunt.UsersTest do
  use GigsHunt.ModelCase

  alias GigsHunt.Users

  @valid_attrs %{email: "some content", enc_password: "some content", profile: %{}, username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Users.changeset(%Users{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Users.changeset(%Users{}, @invalid_attrs)
    refute changeset.valid?
  end
end
