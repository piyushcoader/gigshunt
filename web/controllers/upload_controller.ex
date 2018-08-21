defmodule GigsHunt.UploadController do
  use GigsHunt.Web, :controller

  def create(%Plug.Conn{private: %{:absinthe => %{context: user_info}}}= conn, %{"file" => file} = params) do
    {result, url} = GigsHunt.Uploads.upload(%{"file" => file})
    
    conn
    |> text(url)
  end

  def create( conn, _params) do
    IO.inspect conn
    conn
    |>put_status(:error)
    |> text("please Login to upload")
  end
end
