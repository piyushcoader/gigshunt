defmodule GigsHunt.GTest.User do
  use ExUnit.Case

  test "user info detail graphql query is working fine" do
    result = """
      user_info(id: 1){
        id
      }
    """ |> Absinthe.run(GigsHunt.Schema)

   assert elem(result,0) == :ok
  end
end
