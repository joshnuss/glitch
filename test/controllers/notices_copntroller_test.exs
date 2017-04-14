defmodule Glitch.NoticeControllerTest do
  use Glitch.ConnCase

  test "POST / creates notices", %{conn: conn} do
    conn = post(conn, "/api/v3/projects/101/notices")

    assert json_response(conn, :created) == %{"project_id" => "101"}
  end

  test "POST / returns 401 when unauthorized", %{conn: conn} do
    conn = post(conn, "/api/v3/projects/1/notices")

    assert json_response(conn, :unauthorized) == %{"error" => "Unauthorized. project_key was not found or is invalid."}
  end

  test "POST / returns 400 when bad request", %{conn: conn} do
    conn = post(conn, "/api/v3/projects/2/notices")

    assert json_response(conn, :bad_request) == %{"error" => "Bad request. Invalid data received."}
  end

  test "POST / returns 403 when forbidden", %{conn: conn} do
    conn = post(conn, "/api/v3/projects/3/notices")

    assert json_response(conn, :forbidden) == %{"error" => "Request forbidden."}
  end

  test "POST / returns 429 when too many requests", %{conn: conn} do
    conn = post(conn, "/api/v3/projects/4/notices")

    assert json_response(conn, :too_many_requests) == %{"error" => "Too many requests, try again later."}
  end
end
