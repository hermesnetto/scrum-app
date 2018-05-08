defmodule ScrumApp.Scrum.Phase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "phases" do
    field :title, :string
    field :index, :integer, default: 0
    field :task_count, :integer, default: 0
    belongs_to :project, ScrumApp.Scrum.Project
    belongs_to :sprint, ScrumApp.Scrum.Sprint

    timestamps()
  end

  @doc false
  def changeset(phase, attrs) do
    phase
    |> cast(attrs, [:title, :task_count, :index, :project_id, :sprint_id])
    |> validate_required([:title, :task_count, :index, :project_id, :sprint_id])
  end
end
