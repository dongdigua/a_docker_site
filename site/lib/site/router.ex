defmodule Site.Router do
  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  get "/" do
    content = File.read!("www/home.html")
    send_resp(conn, 200, content)
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
    Logger.info("read ttt page")
    send_resp(conn, 200, content)
  end

  get "/input" do
    content = File.read!("www/input.html")
    Logger.info("input page")
    send_resp(conn, 200, content)
  end

  get "/view" do
    Logger.info("viewing database")
    content = Site.Req.all_blocks()
    send_resp(conn, 200, content)
  end

  get "/video" do
    content = File.read!("www/video.mp4")
    Logger.info("video!")
    send_resp(conn, 200, content)
  end

  get "/yourinput" do
    result = Site.Req.add_to_block(conn.query_string)
    send_resp(conn, 200, result)
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end
