defmodule ScrumApp.Scrum do
  @moduledoc """
  The Scrum context.
  """

  import Ecto.Query, warn: false
  alias ScrumApp.Repo

  alias ScrumApp.Scrum.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{source: %Project{}}

  """
  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end

  alias ScrumApp.Scrum.Sprint

  @doc """
  Returns the list of sprints.

  ## Examples

      iex> list_sprints()
      [%Sprint{}, ...]

  """
  def list_sprints do
    Repo.all(Sprint)
  end

  @doc """
  Gets a single sprint.

  Raises `Ecto.NoResultsError` if the Sprint does not exist.

  ## Examples

      iex> get_sprint!(123)
      %Sprint{}

      iex> get_sprint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sprint!(id), do: Repo.get!(Sprint, id)

  @doc """
  Creates a sprint.

  ## Examples

      iex> create_sprint(%{field: value})
      {:ok, %Sprint{}}

      iex> create_sprint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sprint(attrs \\ %{}) do
    %Sprint{}
    |> Sprint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sprint.

  ## Examples

      iex> update_sprint(sprint, %{field: new_value})
      {:ok, %Sprint{}}

      iex> update_sprint(sprint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sprint(%Sprint{} = sprint, attrs) do
    sprint
    |> Sprint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Sprint.

  ## Examples

      iex> delete_sprint(sprint)
      {:ok, %Sprint{}}

      iex> delete_sprint(sprint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sprint(%Sprint{} = sprint) do
    Repo.delete(sprint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sprint changes.

  ## Examples

      iex> change_sprint(sprint)
      %Ecto.Changeset{source: %Sprint{}}

  """
  def change_sprint(%Sprint{} = sprint) do
    Sprint.changeset(sprint, %{})
  end

  alias ScrumApp.Scrum.Phase

  @doc """
  Returns the list of phases.

  ## Examples

      iex> list_phases()
      [%Phase{}, ...]

  """
  def list_phases do
    Repo.all(Phase)
  end

  @doc """
  Gets a single phase.

  Raises `Ecto.NoResultsError` if the Phase does not exist.

  ## Examples

      iex> get_phase!(123)
      %Phase{}

      iex> get_phase!(456)
      ** (Ecto.NoResultsError)

  """
  def get_phase!(id), do: Repo.get!(Phase, id)

  @doc """
  Creates a phase.

  ## Examples

      iex> create_phase(%{field: value})
      {:ok, %Phase{}}

      iex> create_phase(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_phase(attrs \\ %{}) do
    %Phase{}
    |> Phase.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates the default phases
  """
  def create_default_phases(%{id: sprint_id, project_id: project_id} \\ %{}) do
    phase_list = [{0, "Backlog"}, {1, "ToDo"}, {2, "Doing"}, {3, "Done"}, {4, "Archieved"}]
    phase = %{"sprint_id" => sprint_id,
      "project_id" => project_id,
      "task_count" => 0}

    Enum.each(phase_list, fn(p) ->
      phase
      |> Map.merge(%{"title" => elem(p, 1), "index" => elem(p, 0)})
      |> create_phase()
    end)
  end

  @doc """
  Updates a phase.

  ## Examples

      iex> update_phase(phase, %{field: new_value})
      {:ok, %Phase{}}

      iex> update_phase(phase, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_phase(%Phase{} = phase, attrs) do
    phase
    |> Phase.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Phase.

  ## Examples

      iex> delete_phase(phase)
      {:ok, %Phase{}}

      iex> delete_phase(phase)
      {:error, %Ecto.Changeset{}}

  """
  def delete_phase(%Phase{} = phase) do
    Repo.delete(phase)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking phase changes.

  ## Examples

      iex> change_phase(phase)
      %Ecto.Changeset{source: %Phase{}}

  """
  def change_phase(%Phase{} = phase) do
    Phase.changeset(phase, %{})
  end

  alias ScrumApp.Scrum.History

  @doc """
  Returns the list of histories.

  ## Examples

      iex> list_histories()
      [%History{}, ...]

  """
  def list_histories do
    Repo.all(History)
  end

  @doc """
  Gets a single history.

  Raises `Ecto.NoResultsError` if the History does not exist.

  ## Examples

      iex> get_history!(123)
      %History{}

      iex> get_history!(456)
      ** (Ecto.NoResultsError)

  """
  def get_history!(id), do: Repo.get!(History, id)

  @doc """
  Creates a history.

  ## Examples

      iex> create_history(%{field: value})
      {:ok, %History{}}

      iex> create_history(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_history(attrs \\ %{}) do
    %History{}
    |> History.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a history.

  ## Examples

      iex> update_history(history, %{field: new_value})
      {:ok, %History{}}

      iex> update_history(history, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_history(%History{} = history, attrs) do
    history
    |> History.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a History.

  ## Examples

      iex> delete_history(history)
      {:ok, %History{}}

      iex> delete_history(history)
      {:error, %Ecto.Changeset{}}

  """
  def delete_history(%History{} = history) do
    Repo.delete(history)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking history changes.

  ## Examples

      iex> change_history(history)
      %Ecto.Changeset{source: %History{}}

  """
  def change_history(%History{} = history) do
    History.changeset(history, %{})
  end

  alias ScrumApp.Scrum.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    if attrs["is_backlog"] == true do
      query = from p in "phases",
              where: p.index == 0 and p.project_id == ^attrs["project_id"],
              select: p.id
      
      with phase_id <- Repo.one!(query) do
        %Task{}
        |> Task.changeset(Map.merge(attrs, %{"phase_id" => phase_id}))
        |> Repo.insert()
      end
    else
      %Task{}
      |> Task.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end
end
