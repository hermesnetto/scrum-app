defmodule ScrumApp.Scrum.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :estimate, :float
    field :title, :string
    belongs_to :project, ScrumApp.Scrum.Project
    belongs_to :sprint, ScrumApp.Scrum.Sprint
    belongs_to :history, ScrumApp.Scrum.History
    belongs_to :phase, ScrumApp.Scrum.Phase

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :estimate, :project_id, :sprint_id, :history_id, :phase_id])
    |> validate_required([:title, :description, :estimate, :project_id, :sprint_id, :history_id, :phase_id])
  end
end
