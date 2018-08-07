defmodule Agala.Provider.Facebook.Helpers.Users do
  alias Agala.Provider.Facebook.Helpers.Send

  @doc """
  Params:
  * `user_ids` - facebook user id's
  """
  def get_user_info(user_id, token) do
    case HTTPoison.get(
           "https://graph.facebook.com/#{user_id}?fields=first_name,last_name&access_token=#{token}"
         ) do
      {:ok, %{body: body} = response} -> Jason.decode(body)
      error -> error
    end
  end

  def get_user_info2(conn, user_id) do
    Map.put(conn, :response, %{
      method: :get,
      payload: %{
        body: %{},
        headers: [{"Content-Type", "application/json"}],
        url_path: "#{user_id}?fields=first_name,last_name"
      }
    })
    |> Send.perform_request()
  end
end
