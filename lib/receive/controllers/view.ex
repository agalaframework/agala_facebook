defmodule Agala.Provider.Facebook.Controllers.View do
  alias Plug.Conn

  def render_raw(conn, :ok, raw_data \\ "") do
    conn
    |> Conn.put_resp_content_type("application/json")
    |> Conn.send_resp(:ok, raw_data)
  end

  def render(conn, status, data \\ [])
  def render(conn, :ok, data) do
    conn
    |> Conn.put_resp_content_type("application/json")
    |> Conn.send_resp(:ok, Jason.encode!(data))
  end

  def render(conn, status, errors) do
    conn
    |> Conn.put_resp_content_type("application/json")
    |> Conn.send_resp(status, Jason.encode!(%{errors: errors}))
    |> Conn.halt()
  end
end