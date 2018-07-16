defmodule Agala.Provider.Facebook.Controllers.Verification do
  alias Plug.Conn

  alias Agala.Provider.Facebook.Controllers.View

  def handle(conn) do
    conn
    |> Conn.fetch_query_params()
    |> verify_request()
  end

  defp verify_request(%{
         query_params: %{
           "hub.mode" => "subscribe",
           # We match both tokens as pattern matching
           "hub.verify_token" => verify_token,
           "hub.challenge" => challenge
         },
         private: %{
           agala_bot_config: %{
             provider_params: %{
               # We match both tokens as pattern matching
               verify_token: verify_token
             }
           }
         }
       } = conn) do
        conn
        |> View.render_raw(:ok, challenge)
  end

  defp verify_request(conn) do
    IO.inspect(conn)
    conn
    |> View.render(:unauthorized, %{error: "unauthorized!"})
  end
end
