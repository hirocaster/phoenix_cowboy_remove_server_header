defmodule PhoenixCowboyRemoveServerHeader.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_cowboy_remove_server_header,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: "Remove `server: Cowboy` in http headers from Phoenix",
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:cowboy, "~> 1.0"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [# These are the default files included in the package
      name: :phoenix_cowboy_remove_server_header,
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["hirocaster"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/hirocaster/phoenix_cowboy_remove_server_header"}]
  end
end
