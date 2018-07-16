defmodule Agala.Provider.Facebook.Helpers.Send do
  @api_version "2.6"

  def base_url(token) do
    "https://graph.facebook.com/v" <> @api_version <> "/me/messages?access_token" <> token
  end

  def messages(page_name, payload, opts) do
    # :hackney.post(

    # )
  end
end
