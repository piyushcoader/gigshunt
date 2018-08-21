defmodule GigsHunt.GTest.Category do
  use ExUnit.Case

  test "graphql  query to return all category" do
    result = """
      query category{
          id
      }
    """ |> Absinthe.run(GigsHunt.Schema)

    assert  elem(result,0) == :ok

  end

  test "graphql query works fine for sub_category" do
    result = """
      query sub_category{
        id
      }
    """ |> Absinthe.run(GigsHunt.Schema)

    assert elem(result,0) == :ok 
  end
end
