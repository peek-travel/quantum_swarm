use Mix.Config

config :quantum_swarm, QuantumSwarm.Scheduler,
  global: true,
  jobs: [
    {{:extended, "*/3"}, {QuantumSwarm.Pinger, :ping, []}}
  ]

import_config "#{Mix.env()}.exs"
