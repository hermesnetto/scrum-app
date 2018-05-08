defmodule ScrumAppWeb.ProjectController do
  use ScrumAppWeb, :controller

  alias ScrumApp.Scrum
  alias ScrumApp.Scrum.Project

  action_fallback ScrumAppWeb.FallbackController

  def index(conn, _params) do
    projects = Scrum.list_projects()
    render(conn, "index.json", projects: projects)
  end

  def create(conn, params) do
    with {:ok, %Project{} = project} <- Scrum.create_project(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", project_path(conn, :show, project))
      |> render("show.json", project: project)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Scrum.get_project!(id)
    render(conn, "show.json", project: project)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Scrum.get_project!(id)

    with {:ok, %Project{} = project} <- Scrum.update_project(project, project_params) do
      render(conn, "show.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Scrum.get_project!(id)
    with {:ok, %Project{}} <- Scrum.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
