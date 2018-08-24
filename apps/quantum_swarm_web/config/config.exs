# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quantum_swarm_web,
  namespace: QuantumSwarmWeb

# Configures the endpoint
config :quantum_swarm_web, QuantumSwarmWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5KczVAh12t5kG0KhZJI4+2jv9OHOaDzZMr2QnTZnXGuNgBGDDRoZYH9l/2Av2enI",
  render_errors: [view: QuantumSwarmWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: QuantumSwarmWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :quantum_swarm_web, :generators,
  context_app: :quantum_swarm

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
