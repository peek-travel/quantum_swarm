defmodule QuantumSwarmWeb.PageController do
  use QuantumSwarmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
