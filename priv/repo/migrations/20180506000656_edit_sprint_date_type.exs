defmodule ScrumApp.Repo.Migrations.EditSprintDateType do
  use Ecto.Migration

  def change do
    alter table(:sprints) do
      modify :init_date, :string
      modify :end_date, :string
    end
  end
end
