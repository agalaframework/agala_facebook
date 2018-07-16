defmodule Agala.Provider.Facebook.Plug do
  @moduledoc """
  This module can be used as Plug for
  """

  ############################################################################
  # Router for messenger webhooks                                            #
  ############################################################################

  use Plug.Router
  alias Agala.Provider.Facebook.Plugs.{RawBodyExtractor, Validator}
  alias Agala.Provider.Facebook.Controllers.{Verification, View, Callback}
  # alias MessengerBot.Web.Controller.Messenger
  # alias MessengerBot.Web.Plug.{MaxBodyLength, AppAuthentication, Transaction, EventBus}

  plug(RawBodyExtractor)
  plug(Validator)
  plug(:match)
  plug(:dispatch)

  ############################################################################
  # All Facebook Messenger webhook events will hit to this endpoint
  # POST /:app_id
  ############################################################################
  post(_, do: Callback.handle(conn))

  # GET / - Webhook verification
  get(_, do: Verification.handle(conn))

  # 404 response to all other routes
  match(_, do: View.render(conn, :not_found, %{page: "Not found!"}))
end
