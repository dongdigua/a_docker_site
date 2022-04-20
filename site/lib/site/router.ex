defmodule Site.Router do
  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200,
    """
    Welcome!
    visit /server to get the status of PPP server
    visit /beam to view the beam book
    """)
  end

  get "/server" do
    state = MCPing.get_info("ppp.vancraft.cn") |> inspect
    Logger.info("get ppp state: #{state}")
    send_resp(conn, 200, state)
  end

  get "/beam" do
    content = File.read!("The Erlang Runtime System.html")
    Logger.info("read beam book html")
    send_resp(conn, 200, content)
  end

  get "/test" do
    content = File.read!("test.html")
    Logger.info("read test page")
    send_resp(conn, 200, content)
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end
