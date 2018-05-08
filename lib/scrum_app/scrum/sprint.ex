defmodule ScrumApp.Scrum.Sprint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sprints" do
    field :end_date, :string
    field :init_date, :string
    field :finished, :boolean, default: false
    belongs_to :project, ScrumApp.Scrum.Project
    has_many :phases, ScrumApp.Scrum.Phase
    has_many :histories, ScrumApp.Scrum.History
    has_many :tasks, ScrumApp.Scrum.Task

    timestamps()
  end

  @doc false
  def changeset(sprint, attrs) do
    sprint
    |> cast(attrs, [:init_date, :end_date, :finished, :project_id])
    |> validate_required([:init_date, :end_date, :finished, :project_id])
  end
end
