SlackWebhook
============

Sends simple messages to Slack channel using webhook API.

## Usage

1. Register new integration here: https://my.slack.com/services/new/incoming-webhook/
   You will receive Webhook URL similar to https://hooks.slack.com/services/*/*/*

2. Add dependency in `mix.exs`.

    {:slack_webhook, "~> 0.1.0"}

3. Add Webhook URL to your application configuration.

    config :slack_webhook, :url, "https://hooks.slack.com/services/*/*/*"

4. Send synchronous message.

    SlackWebhook.send "lorem ipsum"

5. Send asynchronous message.

    SlackWebhook.async_send "lorem ipsum"

## Sync vs Async

Unless you want to handle exceptions, use `async_send`. 
If you compare synchronous:

    iex(10)> :timer.tc fn -> SlackWebhook.send "test" end
    {239446,

And asynchronous:

    iex(10)> :timer.tc fn -> SlackWebhook.async_send "test" end
    {604, {:ok, %HTTPoison.AsyncResponse{id: #Reference<0.0.2.666>}}}

You will get: 

send (avg)| async_send (avg)
----------|-----------------
239446 us | 685 us

Of course, in asynchronous code we don't wait for reply to handle possible errors and that's where the boost come from.
If you use Slack notifications for anything critical, use `send`.
Otherwise, use `async_send`, enjoy speed and clear process mailbox from time to time.


