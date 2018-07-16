defmodule Agala.Provider.Facebook.Chains.JSONDecoder do
  @behaviour Agala.Chain

  def init(args), do: args

  def call(%Agala.Conn{request: body} = conn, _opts) do
    put_in(conn, [:body], Jason.decode!(body))
  end
end
