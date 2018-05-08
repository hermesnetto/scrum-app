defmodule ScrumAppWeb.PageController do
  use ScrumAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
