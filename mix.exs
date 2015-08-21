defmodule SlackWebhook.Mixfile do
  use Mix.Project

  def project do
    [app: :slack_webhook,
     description: "Sends simple messages to Slack channel using webhook API.",
     version: "0.0.2",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:httpoison, "~> 0.7.2"}]
  end

  defp package do
    [
      licenses: ["CC0"],
      contributors: ["Remigiusz Jackowski"],
      links: %{
        "GitHub" => "https://github.com/remiq/slack_webhook"
      }
    ]
  end
end
