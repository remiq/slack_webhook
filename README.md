SlackWebhook
============

Sends simple messages to Slack channel using webhook API.

## Usage

1. Register new integration here: https://my.slack.com/services/new/incoming-webhook/
   You will receive Webhook URL similar to https://hooks.slack.com/services/*/*/*

2. Add dependency in `mix.exs`.

    {:slack_webhook, "~> 0.0.1"}

3. Add Webhook URL to your application configuration.

    config :slack_webhook, :url, "https://hooks.slack.com/services/*/*/*"

4. Send message.

    SlackWebhook.send "lorem ipsum"



