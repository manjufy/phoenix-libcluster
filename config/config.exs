# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
#config :phoenix_libcluster

# Configures the endpoint
config :phoenix_libcluster, PhoenixLibcluster.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5Wbf6vVCqSmpYYj5ldo7LGxcsDDY5Bau6uSFPkAH0Zeb0FQHJbmpTY1X+oAMjzNl",
  render_errors: [view: PhoenixLibcluster.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixLibcluster.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  level: :debug

# config :libcluster,
#     topologies: [
#       k8s: [
#         strategy: Cluster.Strategy.Kubernetes,
#         config: [
#           kubernetes_selector: "app=phoenix_libcluster",
#           kubernetes_node_basename: "phoenix_libcluster"
#         ]
#       ]
#   ]

config :libcluster,
    topologies: [
      k8s: [
        strategy: Cluster.Strategy.Kubernetes,
        config: [
          kubernetes_selector: "app=phoenix-libcluster",
          kubernetes_node_basename: "phoenix-libcluster"
        ]
      ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
