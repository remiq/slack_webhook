defmodule SlackWebhook do
  @moduledoc """
  Sends simple HTTP(S) request to Slack API to display short message on your channel.
  Remember to configure your webhook at config/config.exs:
        config :slack_webhook, :url, "https://hooks.slack.com/services/*/*/*"
  """

  @doc """
  Sends message to default channel.
  """
  def send(msg), do: __MODULE__.send(msg, get_url)

  @doc """
  Sends message to selected webhook url.
  Use if your application uses more than one hook.
  """
  def send(msg, url), do: HTTPoison.post(url, get_content(msg))

  @doc """
  Sends asynchronous message to selected webhook url.
  Use when you want to "fire and forget" your notifications.
  """
  def async_send(msg), do: __MODULE__.async_send(msg, get_url)

  @doc """
  Sends asynchronous message to selected webhook url.
  """
  def async_send(msg, url), do: HTTPoison.post(url, get_content(msg), [], [hackney: [:async]])

  defp get_url, do: Application.get_env(:slack_webhook, :url, "")
  defp get_content(msg), do: """
  {
    "text": "#{msg}"
  }
  """

end
