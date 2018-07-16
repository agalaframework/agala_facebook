defmodule Agala.Provider.Facebook.Plugs.Validator do
  @moduledoc """
  This plug is used to verify SHA-1 signature of the Webhook request.
  """

  alias Plug.Conn
  alias Agala.Provider.Facebook.Util.Encryption
  alias Agala.Provider.Facebook.Controllers.View

  @behaviour Plug

  @doc false
  def init(opts), do: opts

  @doc false
  def call(%{method: "POST"} = conn, _opts) do
    case conn.private[:agala_bot_config][:provider_params] do
      # todo: add better logging
      nil ->
        raise ArgumentError, "provider_params is not specified for your bot"
      %{app_secret: app_secret} ->
        validate_signature(conn, app_secret)
      _ -> raise ArgumentError, "app_secret is not provided for your bot"
    end
  end

  # We skip checks for non-POST requests
  def call(conn, _) do
    conn
  end

  def validate_signature(conn, app_secret) do
    case fetch_signature(conn) do
      ["sha1=" <> signature] ->
        case Encryption.validate_sha1(app_secret, conn.private[:body], signature) do
          :ok -> conn
          {:error, error} -> View.render(conn, :unauthorized, error)
        end

      _ ->
        View.render(conn, :unauthorized, %{signature: "required"})
    end
  end

  defp fetch_signature(conn) do
    Conn.get_req_header(conn, "x-hub-signature")
  end
end
