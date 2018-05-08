defmodule ScrumApp.Repo.Migrations.CreateSprints do
  use Ecto.Migration

  def change do
    create table(:sprints) do
      add :init_date, :date
      add :end_date, :date
      add :finished, :boolean, default: false, null: false
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:sprints, [:project_id])
  end
end
