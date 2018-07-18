defmodule Agala.Provider.Facebook do
  use Agala.Provider

  def get_bot(:plug), do: Agala.Provider.Facebook.Plug
end
