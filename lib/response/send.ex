defmodule Agala.Provider.Facebook.Helpers.Send do
  @api_version "2.6"

  defp bootstrap(bot) do
    case bot.config() do
      %{bot: ^bot} = bot_params ->
        {:ok,
         Map.put(bot_params, :private, %{
           http_opts:
             (get_in(bot_params, [:provider_params, :hackney_opts]) || [])
             |> Keyword.put(
               :recv_timeout,
               get_in(bot_params, [:provider_params, :response_timeout]) || 5000
             )
         })}

      error ->
        error
    end
  end

  def base_url(token, path) do
    "https://graph.facebook.com/v" <> @api_version <> path <> "?access_token=" <> token
  end

  defp body_encode(body) when is_bitstring(body), do: body
  defp body_encode(body) when is_map(body), do: body |> Jason.encode!()
  defp body_encode(_), do: ""

  def perform_request(%Agala.Conn{
        responser: bot,
        response: %{method: method, payload: %{body: body, url_path: url_path} = payload}
      }) do
    {:ok, bot_params} = bootstrap(bot)

    case HTTPoison.request(
           method,
           base_url(bot_params.provider_params.page_access_token, url_path),
           body_encode(body),
           Map.get(payload, :headers, []),
           Map.get(payload, :http_opts) || Map.get(bot_params.private, :http_opts) || []
         ) do
      {:ok, %HTTPoison.Response{body: body}} -> {:ok, Jason.decode!(body)}
      error -> error
    end
  end

  @spec message(conn :: Agala.Conn.t(), recipient_id :: String.t(), text :: String.t()) ::
          Agala.Conn.t()
  def message(conn, recipient_id, text) do
    Map.put(conn, :response, %{
      method: :post,
      payload: %{
        body: %{recipient: %{id: recipient_id}, message: %{text: text}},
        headers: [{"Content-Type", "application/json"}],
        url_path: "/me/messages"
      }
    })
    |> perform_request()
  end
end
