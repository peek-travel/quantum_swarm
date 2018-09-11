defmodule QuantumSwarm.Application do
  @moduledoc """
  The QuantumSwarm Application Service.

  The quantum_swarm system business domain lives in this application.

  Exposes API to clients such as the `QuantumSwarmWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # worker(QuantumSwarm.Scheduler, [])
    ]

    resp = Supervisor.start_link(children, strategy: :one_for_one, name: QuantumSwarm.Supervisor)

    {:ok, _pid} = Swarm.register_name(ThePonger, QuantumSwarm.Ponger, :start_link, [])

    resp
  end
end
