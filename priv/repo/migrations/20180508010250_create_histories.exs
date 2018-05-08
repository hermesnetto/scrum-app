defmodule ScrumApp.Repo.Migrations.CreateHistories do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :title, :string
      add :description, :text
      add :estimate, :float
      add :project_id, references(:projects, on_delete: :nothing)
      add :sprint_id, references(:sprints, on_delete: :nothing)

      timestamps()
    end

    create index(:histories, [:project_id])
    create index(:histories, [:sprint_id])
  end
end
