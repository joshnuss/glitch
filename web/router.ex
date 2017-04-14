defmodule Glitch.Router do
  use Glitch.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Glitch do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/v3", Glitch do
    pipe_through :api

    resources "/projects/:project_id/notices", NoticeController, only: [:create]
  end
end
