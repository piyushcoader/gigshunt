defmodule GigsHunt.Router do
  use GigsHunt.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :graphql do

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug GigsHunt.Web.Context

 end



  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug GigsHunt.Web.Context
  end

  scope "/", GigsHunt do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug,
      schema: GigsHunt.Schema
    end

  forward "/graphiql", Absinthe.Plug.GraphiQL,
  schema: GigsHunt.Schema

  # Other scopes may use custom stacks.
  scope "/rest/", GigsHunt do
     pipe_through :api

     post "/upload", UploadController, :create

  end
end
