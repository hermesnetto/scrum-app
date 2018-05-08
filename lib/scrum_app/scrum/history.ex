defmodule ScrumApp.Scrum.History do
  use Ecto.Schema
  import Ecto.Changeset


  schema "histories" do
    field :description, :string
    field :estimate, :float, default: 0
    field :title, :string
    belongs_to :project, ScrumApp.Scrum.Project
    belongs_to :sprint, ScrumApp.Scrum.Sprint
    has_many :tasks, ScrumApp.Scrum.Task

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:title, :description, :estimate, :project_id, :sprint_id])
    |> validate_required([:title, :description, :estimate, :project_id, :sprint_id])
  end
end
