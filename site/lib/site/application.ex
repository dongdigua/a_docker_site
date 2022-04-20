defmodule Site.Application do

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Site.Router, options: [port: 8080]}
    ]
    opts = [strategy: :one_for_one, name: Site.Supervisor]
    Logger.info("Starting Application...")
    Supervisor.start_link(children, opts)
  end
end
