defmodule GigsHunt.GTest.Roles do
  use ExUnit.Case

  test "fetching roles from graphql schema" do
    result ="""
      query role{
        id
      }
    """ |> Absinthe.run(GigsHunt.Schema)

    assert elem(result,0) == :ok

  end
end
