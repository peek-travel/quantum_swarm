defmodule QuantumSwarm.Ponger do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_args) do
    Process.send_after(self(), :pong, 3000)
    {:ok, 0}
  end

  def handle_info(:pong, counter) do
    IO.puts("------> PONG! #{counter}")
    Process.send_after(self(), :pong, 3000)
    {:noreply, counter + 1}
  end

  # this message is sent when this process should die
  # because it is being moved, use this as an opportunity
  # to clean up
  def handle_info({:swarm, :die}, counter) do
    IO.puts("------> DIE! counter=#{counter}")
    {:stop, :shutdown, counter}
  end

  # called when a handoff has been initiated due to changes
  # in cluster topology, valid response values are:
  #
  #   - `:restart`, to simply restart the process on the new node
  #   - `{:resume, state}`, to hand off some state to the new process
  #   - `:ignore`, to leave the process running on its current node
  #
  def handle_call({:swarm, :begin_handoff}, _from, counter) do
    IO.puts("------> BEGIN HANDOFF! counter=#{counter}")
    {:reply, {:resume, counter}, counter}
  end

  # called after the process has been restarted on its new node,
  # and the old process' state is being handed off. This is only
  # sent if the return to `begin_handoff` was `{:resume, state}`.
  # **NOTE**: This is called *after* the process is successfully started,
  # so make sure to design your processes around this caveat if you
  # wish to hand off state like this.
  def handle_cast({:swarm, :end_handoff, my_counter}, their_counter) do
    IO.puts("------> END HANDOFF! my_counter=#{my_counter} their_counter=#{their_counter}")
    {:noreply, my_counter}
  end

  # called when a network split is healed and the local process
  # should continue running, but a duplicate process on the other
  # side of the split is handing off its state to us. You can choose
  # to ignore the handoff state, or apply your own conflict resolution
  # strategy
  def handle_cast({:swarm, :resolve_conflict, my_counter}, their_counter) do
    IO.puts("------> RESOLVE CONFLICT! my_counter=#{my_counter} their_counter=#{their_counter}")
    {:noreply, max(my_counter, their_counter)}
  end
end
