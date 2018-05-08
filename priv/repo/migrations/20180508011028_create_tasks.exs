defmodule ScrumApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :estimate, :float, default: 0
      add :project_id, references(:projects, on_delete: :nothing)
      add :phase_id, references(:phases, on_delete: :nothing)
      add :sprint_id, references(:sprints, on_delete: :nothing)
      add :history_id, references(:histories, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:project_id])
    create index(:tasks, [:phase_id])
    create index(:tasks, [:sprint_id])
    create index(:tasks, [:history_id])
  end
end
