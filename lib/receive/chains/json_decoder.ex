defmodule Agala.Provider.Facebook.Chains.JsonDecoder do
  @behaviour Agala.Chain

  def init(args), do: args

  def call(%Agala.Conn{request: body} = conn, _opts) when is_binary(body) do
    put_in(conn, [:request], Jason.decode!(body))
  end
end
