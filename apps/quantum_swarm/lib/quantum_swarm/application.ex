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

    Supervisor.start_link([], strategy: :one_for_one, name: QuantumSwarm.Supervisor)
  end
end
