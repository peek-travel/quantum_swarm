defmodule QuantumSwarm.Pinger do
  require Logger

  def ping do
    Logger.info(fn -> "PING!" end)
  end
end
