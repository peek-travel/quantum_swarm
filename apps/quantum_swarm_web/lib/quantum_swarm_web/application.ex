defmodule QuantumSwarmWeb.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(QuantumSwarmWeb.Endpoint, [])
      # Start your own worker by calling: QuantumSwarmWeb.Worker.start_link(arg1, arg2, arg3)
      # worker(QuantumSwarmWeb.Worker, [arg1, arg2, arg3]),
    ]

    children =
      case Application.get_env(:libcluster, :topologies) do
        nil ->
          children

        topologies ->
          [
            {Cluster.Supervisor, [topologies, [name: QuantumSwarmWeb.ClusterSupervisor]]}
            | children
          ]
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QuantumSwarmWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QuantumSwarmWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
