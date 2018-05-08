defmodule ScrumAppWeb.HistoryController do
  use ScrumAppWeb, :controller

  alias ScrumApp.Scrum
  alias ScrumApp.Scrum.History

  action_fallback ScrumAppWeb.FallbackController

  def index(conn, _params) do
    histories = Scrum.list_histories()
    render(conn, "index.json", histories: histories)
  end

  def create(conn, params) do
    with {:ok, %History{} = history} <- Scrum.create_history(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", history_path(conn, :show, history))
      |> render("show.json", history: history)
    end
  end

  def show(conn, %{"id" => id}) do
    history = Scrum.get_history!(id)
    render(conn, "show.json", history: history)
  end

  def update(conn, %{"id" => id, "history" => history_params}) do
    history = Scrum.get_history!(id)

    with {:ok, %History{} = history} <- Scrum.update_history(history, history_params) do
      render(conn, "show.json", history: history)
    end
  end

  def delete(conn, %{"id" => id}) do
    history = Scrum.get_history!(id)
    with {:ok, %History{}} <- Scrum.delete_history(history) do
      send_resp(conn, :no_content, "")
    end
  end
end
