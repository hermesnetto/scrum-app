defmodule ScrumApp.Repo.Migrations.CreatePhases do
  use Ecto.Migration

  def change do
    create table(:phases) do
      add :title, :string
      add :task_count, :integer
      add :project_id, references(:projects, on_delete: :nothing)
      add :sprint_id, references(:sprints, on_delete: :nothing)

      timestamps()
    end

    create index(:phases, [:project_id])
    create index(:phases, [:sprint_id])
  end
end
