defmodule GigsHunt.GTest.Gigs do
  use ExUnit.Case

  test "testing gigs mutation " do
    result ="""
    mutation InsertGigs($gigs: gigsInput, $packages: packageInput){
      insert_gigs(gigs: $gigs,packages: $packages){
      id,
      packages{
          id,
          title
      }
    }
  }
    """ |> Absinthe.run(GigsHunt.Schema, variables: %{"gigs" => %{ "title" => "test title", "sub_category_id" => 1, "description" => "" }, "packages" => [] })
    IO.inspect result
    assert elem(result,0) == :ok

  end
end
