defmodule SlackWebhook do
  @moduledoc """
  Sends simple HTTP(S) request to Slack API to display short message on your channel.
  Remember to configure your webhook at config/config.exs:
        config :slack_webhook, :url, "https://hooks.slack.com/services/*/*/*"

        config :slack_webhook,
          default_url: "https://hooks.slack.com/services/*/*/*",
          urls: [some_name: "https://hooks.slack.com/services/*/*/*", other_name: "https://hooks.slack.com/services/*/*/*"]

  """

  @doc """
  Sends message to default channel.
  """
  def send(msg), do: SlackWebhook.send(msg, :default)

  @doc """
  Sends message to selected webhook url.
  Use if your application uses more than one hook.
  """
  def send(msg, key) when is_atom(key), do: HTTPoison.post(get_url(key), get_content(msg))
  def send(msg, url) when is_bitstring(url), do: HTTPoison.post(url, get_content(msg))

  @doc """
  Sends asynchronous message to selected webhook url.
  Use when you want to "fire and forget" your notifications.
  """
  def async_send(msg), do: SlackWebhook.async_send(msg, :default)

  @doc """
  Sends asynchronous message to selected webhook url.
  """
  def async_send(msg, key) when is_atom(key), do: HTTPoison.post(get_url(key), get_content(msg), [], async: true)
  def async_send(msg, url) when is_bitstring(url), do: HTTPoison.post(url, get_content(msg), [], async: true)

  defp get_url(:default), do: Application.get_env(:slack_webhook, :default_url, false) || single_url()
  defp get_url(name), do: :slack_webhook |> Application.get_env(:urls, []) |> Keyword.get(name, "")

  defp single_url, do: Application.get_env(:slack_webhook, :url, "")

  defp get_content(msg), do: """
  {
    "text": "#{msg}"
  }
  """
end
