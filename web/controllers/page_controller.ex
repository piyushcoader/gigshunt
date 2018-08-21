defmodule GigsHunt.PageController do
  use GigsHunt.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
