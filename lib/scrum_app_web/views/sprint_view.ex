defmodule ScrumAppWeb.SprintView do
  use ScrumAppWeb, :view
  alias ScrumAppWeb.SprintView

  def render("index.json", %{sprints: sprints}) do
    %{data: render_many(sprints, SprintView, "sprint.json")}
  end

  def render("show.json", %{sprint: sprint}) do
    %{data: render_one(sprint, SprintView, "sprint.json")}
  end

  def render("sprint.json", %{sprint: sprint}) do
    %{id: sprint.id,
      init_date: sprint.init_date,
      end_date: sprint.end_date,
      finished: sprint.finished}
  end
end
