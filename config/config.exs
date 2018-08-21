# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gigs_hunt,
  ecto_repos: [GigsHunt.Repo]

# Configures the endpoint
config :gigs_hunt, GigsHunt.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "imBBGxUkMbTgCD1fQpyeL8BRgCwbr+zTolpqx2cQOKA7i5NAoSjy6RrVlxh4qTgG",
  render_errors: [view: GigsHunt.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GigsHunt.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "GigsHunt",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "Q/pRXuJQoZblGk4AIOHhMX0AkzuUpBS91hQVlO06PqrtRd/iAobc3CdBkMPDVYgc",
  serializer: GigsHunt.GuardianSerializer

config :ex_aws,
  access_key_id: ["AKIAIP236GYS4CZCCZCA", :instance_role],
  secret_access_key: ["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", :instance_role],
  region: "us-west-2"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
