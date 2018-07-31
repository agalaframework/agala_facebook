defmodule Agala.Provider.Facebook.Controllers.Callback do
  alias Agala.Provider.Facebook.Controllers.View

  def handle(conn) do
    case conn.private.agala_bot_config[:chain] do
      nil -> raise ArgumentError, "chain is not specified"
      chain ->
        chain.call(%Agala.Conn{request: conn.private.body, request_bot_params: conn.private.agala_bot_config}, [])
        |> resolve_response(conn)
    end
  end

  def resolve_response(%Agala.Conn{response: {:error, reason}}, conn) do
    conn
    |> View.render(400, %{errors: reason})
  end
  def resolve_response(%Agala.Conn{response: nil}, conn) do
    conn
    |> View.render(:ok)
  end
end
