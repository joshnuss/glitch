defmodule Glitch.NoticeController do
  use Glitch.Web, :controller

  @errors %{
    unauthorized: "Unauthorized. project_key was not found or is invalid.",
    bad_request: "Bad request. Invalid data received.",
    forbidden: "Request forbidden.",
    too_many_requests: "Too many requests, try again later."
  }

  defmodule Notice do
    def authorized(%{"project_id" => "1"}),
      do: :unauthorized

    def authorized(data),
      do: {:ok, data}

    def valid(%{"project_id" => "2"}),
      do: :bad_request

    def valid(data),
      do: {:ok, data}

    def allowed(%{"project_id" => "3"}),
      do: :forbidden

    def allowed(data),
      do: {:ok, data}

    def throttle(%{"project_id" => "4"}),
      do: :too_many_requests

    def throttle(data),
      do: {:ok, data}

    def write(data),
      do: {:ok, data}
  end

  def create(conn, params) do
    with {:ok, authorized} <- Notice.authorized(params),
         {:ok, valid}      <- Notice.valid(authorized),
         {:ok, allowed}    <- Notice.allowed(valid),
         {:ok, free}       <- Notice.throttle(allowed),
         {:ok, result}     <- Notice.write(free) do
      conn
      |> put_status(:created)
      |> json(result)
    else
      error ->
        conn
        |> put_status(error)
        |> json(%{error: @errors[error]})
    end
  end
end
