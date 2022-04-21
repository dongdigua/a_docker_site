defmodule Site.Router do
  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200,
    """
    Welcome!
    /server : get the status of PPP server
    /beam : to view the beam book
    /ttt : my first js webpage
    """)
  end

  get "/server" do
    state = MCPing.get_info("ppp.vancraft.cn") |> inspect
    Logger.info("get ppp state: #{state}")
    send_resp(conn, 200, state)
  end

  get "/beam" do
    content = File.read!("www/The Erlang Runtime System.html")
    Logger.info("read beam book html")
    send_resp(conn, 200, content)
  end

  get "/ttt" do
    content = File.read!("www/ttt.html")
    Logger.info("read test page")
    send_resp(conn, 200, content)
  end

  get "/input" do
    content = File.read!("www/input.html")
    Logger.info("input page")
    send_resp(conn, 200, content)
  end

  get "/yourinput" do
    query_string = conn.query_string
    Logger.info(query_string)
    result = Site.Req.add_to_block(query_string)
    send_resp(conn, 200, result)
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end
