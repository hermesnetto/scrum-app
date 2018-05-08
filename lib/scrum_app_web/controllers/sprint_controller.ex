defmodule ScrumAppWeb.SprintController do
  use ScrumAppWeb, :controller

  alias ScrumApp.Scrum
  alias ScrumApp.Scrum.Sprint

  action_fallback ScrumAppWeb.FallbackController

  def index(conn, _params) do
    sprints = Scrum.list_sprints()
    render(conn, "index.json", sprints: sprints)
  end

  def create(conn, params) do
    with {:ok, %Sprint{} = sprint} <- Scrum.create_sprint(params) do
      Scrum.create_default_phases(sprint)

      conn
      |> put_status(:created)
      |> put_resp_header("location", sprint_path(conn, :show, sprint))
      |> render("show.json", sprint: sprint)
    end
  end

  def show(conn, %{"id" => id}) do
    sprint = Scrum.get_sprint!(id)
    render(conn, "show.json", sprint: sprint)
  end

  def update(conn, %{"id" => id, "sprint" => sprint_params}) do
    sprint = Scrum.get_sprint!(id)

    with {:ok, %Sprint{} = sprint} <- Scrum.update_sprint(sprint, sprint_params) do
      render(conn, "show.json", sprint: sprint)
    end
  end

  def delete(conn, %{"id" => id}) do
    sprint = Scrum.get_sprint!(id)
    with {:ok, %Sprint{}} <- Scrum.delete_sprint(sprint) do
      send_resp(conn, :no_content, "")
    end
  end
end
