defmodule ScrumApp.Scrum.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :description, :string
    field :title, :string
    has_many :sprints, ScrumApp.Scrum.Sprint
    has_many :phases, ScrumApp.Scrum.Phase
    has_many :histories, ScrumApp.Scrum.History
    has_many :tasks, ScrumApp.Scrum.Task

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
