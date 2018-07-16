defmodule Agala.Provider.Facebook.Plug.Params do
  defstruct verify_token: nil,
            # Secret, can be found in App's general settings
            app_secret: nil,
            # Can be found after connecting **Page** to **Messenger** addon of an app
            page_access_tokens: %{},
            # timeout for responser to receive response - normal
            response_timeout: nil,
            hackney_opts: Keyword.new()

    @type t :: %__MODULE__{
      verify_token: String.t(),
      app_secret: String.t(),
      page_access_tokens: %{atom() => String.t()},
      response_timeout: integer() | :infinity,
      hackney_opts: Keyword.t()
    }
end
