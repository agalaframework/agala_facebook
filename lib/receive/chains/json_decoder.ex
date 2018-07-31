defmodule Agala.Provider.Facebook.Chains.JsonDecoder do
  @behaviour Agala.Chain

  def init(args), do: args

  def call(%Agala.Conn{request: request} = conn, _opts) when is_binary(request) do
  	conn
  	|> Map.put(:request, Jason.decode!(request))
  end
end
