defmodule ScrumAppWeb.PhaseController do
  use ScrumAppWeb, :controller

  alias ScrumApp.Scrum
  alias ScrumApp.Scrum.Phase

  action_fallback ScrumAppWeb.FallbackController

  def index(conn, _params) do
    phases = Scrum.list_phases()
    render(conn, "index.json", phases: phases)
  end

  def create(conn, params) do
    with {:ok, %Phase{} = phase} <- Scrum.create_phase(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", phase_path(conn, :show, phase))
      |> render("show.json", phase: phase)
    end
  end

  def show(conn, %{"id" => id}) do
    phase = Scrum.get_phase!(id)
    render(conn, "show.json", phase: phase)
  end

  def update(conn, %{"id" => id, "phase" => phase_params}) do
    phase = Scrum.get_phase!(id)

    with {:ok, %Phase{} = phase} <- Scrum.update_phase(phase, phase_params) do
      render(conn, "show.json", phase: phase)
    end
  end

  def delete(conn, %{"id" => id}) do
    phase = Scrum.get_phase!(id)
    with {:ok, %Phase{}} <- Scrum.delete_phase(phase) do
      send_resp(conn, :no_content, "")
    end
  end
end
