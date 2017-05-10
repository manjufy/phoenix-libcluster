defmodule PhoenixLibcluster.PageController do
  use PhoenixLibcluster.Web, :controller

  def index(conn, _params) do
    data = HelloCluster.get(:status_message)
    IO.inspect data
    conn |> render("index.html", content: data)
  end

  def ping(conn, _params) do
    HelloCluster.ping!

    data = HelloCluster.get(:status_message)
    IO.inspect data

    conn |> render("index.html", content: data)
  end

end
