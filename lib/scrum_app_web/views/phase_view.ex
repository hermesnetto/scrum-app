defmodule ScrumAppWeb.PhaseView do
  use ScrumAppWeb, :view
  alias ScrumAppWeb.PhaseView

  def render("index.json", %{phases: phases}) do
    %{data: render_many(phases, PhaseView, "phase.json")}
  end

  def render("show.json", %{phase: phase}) do
    %{data: render_one(phase, PhaseView, "phase.json")}
  end

  def render("phase.json", %{phase: phase}) do
    %{id: phase.id,
      title: phase.title,
      task_count: phase.task_count}
  end
end
