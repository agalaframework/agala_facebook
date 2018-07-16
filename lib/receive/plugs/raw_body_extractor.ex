defmodule Agala.Provider.Facebook.Plugs.RawBodyExtractor do
  @moduledoc """
  This plug is used to extract raw body from the request.

  After the process, raw body can be found under `conn[:private][:body]` key.
  If the body faild to be retreived, plug will halt with 422 error.
  """

  alias Plug.Conn
  alias Agala.Provider.Facebook.Controllers.View

  @behaviour Plug
  # max to read - 128kb of data
  @length 1024 * 128

  @doc false
  def init(opts), do: opts

  @doc false
  def call(%{method: "POST"} = conn, _opts) do
    case Conn.read_body(conn, length: @length) do
      {:ok, body, conn} ->
        # Everything is ok
        Conn.put_private(conn, :body, body)
      _ ->
        View.render(conn, 422, %{body: "could not be read properly!"})
    end
  end

  # We skip get body for for non-POST requests
  def call(conn, _) do
    conn
  end
end
