defmodule Agala.Provider.Facebook.MixProject do
  use Mix.Project

  def project do
    [
      app: :agala_facebook,
      version: "3.0.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:agala, github: "Victoria91/agala", branch: "move-to-agala-2-0-5-with-plugs-for-facebook"},
      {:jason, "~> 1.1"},
      {:plug, "~> 1.6"},
      {:httpoison, "~> 1.2"},
      {:hackney, "~> 1.13"}
    ]
  end

  defp description do
    """
    Facebook provider for Agala framework
    """
  end

  defp package do
    [
      maintainers: ["Dmitry Rubinstein"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/agalaframework/agala_fb"},
      files: ~w(mix.exs README* CHANGELOG* lib)
    ]
  end
end
