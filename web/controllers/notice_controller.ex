defmodule Glitch.NoticeController do
  use Glitch.Web, :controller

  def create(conn, %{"project_id" => "1"}) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "Unauthorized. project_key was not found or is invalid."})
  end

  def create(conn, %{"project_id" => "2"}) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Bad request. Invalid data received."})
  end

  def create(conn, %{"project_id" => "3"}) do
    conn
    |> put_status(:forbidden)
    |> json(%{error: "Request forbidden."})
  end

  def create(conn, %{"project_id" => "4"}) do
    conn
    |> put_status(:too_many_requests)
    |> json(%{error: "Too many requests, try again later."})
  end

  def create(conn, params) do
    conn
    |> put_status(:created)
    |> json(params)
  end
end
