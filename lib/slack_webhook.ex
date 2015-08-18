defmodule SlackWebhook do

  @doc """
  Sends message to default channel.
  Remember to configure your webhook at config/config.exs:
      config :slack_webhook, :url, "https://hooks.slack.com/services/*/*/*"
  """
  def send(msg) do
    __MODULE__.send(msg, Application.get_env(:slack_webhook, :url, ""))
  end

  @doc """
  Sends message to selected webhook url.
  Use if your application uses more than one hook.
  """
  def send(msg, url) do
    HTTPoison.post url, """
    {
      "text": "#{msg}"
    }
    """
  end

end
