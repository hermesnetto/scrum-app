defmodule ScrumAppWeb.TaskController do
  use ScrumAppWeb, :controller

  alias ScrumApp.Scrum
  alias ScrumApp.Scrum.Task

  action_fallback ScrumAppWeb.FallbackController

  def index(conn, _params) do
    tasks = Scrum.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, params) do
    with {:ok, %Task{} = task} <- Scrum.create_task(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Scrum.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Scrum.get_task!(id)

    with {:ok, %Task{} = task} <- Scrum.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Scrum.get_task!(id)
    with {:ok, %Task{}} <- Scrum.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
