defmodule ScrumApp.Repo.Migrations.AddIndexToPhases do
  use Ecto.Migration

  def change do
    alter table(:phases) do
      add :index, :integer, default: 0
    end
  end
end
