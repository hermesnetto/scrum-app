defmodule ScrumApp.ScrumTest do
  use ScrumApp.DataCase

  alias ScrumApp.Scrum

  describe "projects" do
    alias ScrumApp.Scrum.Project

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scrum.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Scrum.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Scrum.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Scrum.create_project(@valid_attrs)
      assert project.description == "some description"
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scrum.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, project} = Scrum.update_project(project, @update_attrs)
      assert %Project{} = project
      assert project.description == "some updated description"
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Scrum.update_project(project, @invalid_attrs)
      assert project == Scrum.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Scrum.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Scrum.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Scrum.change_project(project)
    end
  end

  describe "sprints" do
    alias ScrumApp.Scrum.Sprint

    @valid_attrs %{end_date: ~D[2010-04-17], finished: true, init_date: ~D[2010-04-17]}
    @update_attrs %{end_date: ~D[2011-05-18], finished: false, init_date: ~D[2011-05-18]}
    @invalid_attrs %{end_date: nil, finished: nil, init_date: nil}

    def sprint_fixture(attrs \\ %{}) do
      {:ok, sprint} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scrum.create_sprint()

      sprint
    end

    test "list_sprints/0 returns all sprints" do
      sprint = sprint_fixture()
      assert Scrum.list_sprints() == [sprint]
    end

    test "get_sprint!/1 returns the sprint with given id" do
      sprint = sprint_fixture()
      assert Scrum.get_sprint!(sprint.id) == sprint
    end

    test "create_sprint/1 with valid data creates a sprint" do
      assert {:ok, %Sprint{} = sprint} = Scrum.create_sprint(@valid_attrs)
      assert sprint.end_date == ~D[2010-04-17]
      assert sprint.finished == true
      assert sprint.init_date == ~D[2010-04-17]
    end

    test "create_sprint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scrum.create_sprint(@invalid_attrs)
    end

    test "update_sprint/2 with valid data updates the sprint" do
      sprint = sprint_fixture()
      assert {:ok, sprint} = Scrum.update_sprint(sprint, @update_attrs)
      assert %Sprint{} = sprint
      assert sprint.end_date == ~D[2011-05-18]
      assert sprint.finished == false
      assert sprint.init_date == ~D[2011-05-18]
    end

    test "update_sprint/2 with invalid data returns error changeset" do
      sprint = sprint_fixture()
      assert {:error, %Ecto.Changeset{}} = Scrum.update_sprint(sprint, @invalid_attrs)
      assert sprint == Scrum.get_sprint!(sprint.id)
    end

    test "delete_sprint/1 deletes the sprint" do
      sprint = sprint_fixture()
      assert {:ok, %Sprint{}} = Scrum.delete_sprint(sprint)
      assert_raise Ecto.NoResultsError, fn -> Scrum.get_sprint!(sprint.id) end
    end

    test "change_sprint/1 returns a sprint changeset" do
      sprint = sprint_fixture()
      assert %Ecto.Changeset{} = Scrum.change_sprint(sprint)
    end
  end

  describe "phases" do
    alias ScrumApp.Scrum.Phase

    @valid_attrs %{task_count: 42, title: "some title"}
    @update_attrs %{task_count: 43, title: "some updated title"}
    @invalid_attrs %{task_count: nil, title: nil}

    def phase_fixture(attrs \\ %{}) do
      {:ok, phase} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scrum.create_phase()

      phase
    end

    test "list_phases/0 returns all phases" do
      phase = phase_fixture()
      assert Scrum.list_phases() == [phase]
    end

    test "get_phase!/1 returns the phase with given id" do
      phase = phase_fixture()
      assert Scrum.get_phase!(phase.id) == phase
    end

    test "create_phase/1 with valid data creates a phase" do
      assert {:ok, %Phase{} = phase} = Scrum.create_phase(@valid_attrs)
      assert phase.task_count == 42
      assert phase.title == "some title"
    end

    test "create_phase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scrum.create_phase(@invalid_attrs)
    end

    test "update_phase/2 with valid data updates the phase" do
      phase = phase_fixture()
      assert {:ok, phase} = Scrum.update_phase(phase, @update_attrs)
      assert %Phase{} = phase
      assert phase.task_count == 43
      assert phase.title == "some updated title"
    end

    test "update_phase/2 with invalid data returns error changeset" do
      phase = phase_fixture()
      assert {:error, %Ecto.Changeset{}} = Scrum.update_phase(phase, @invalid_attrs)
      assert phase == Scrum.get_phase!(phase.id)
    end

    test "delete_phase/1 deletes the phase" do
      phase = phase_fixture()
      assert {:ok, %Phase{}} = Scrum.delete_phase(phase)
      assert_raise Ecto.NoResultsError, fn -> Scrum.get_phase!(phase.id) end
    end

    test "change_phase/1 returns a phase changeset" do
      phase = phase_fixture()
      assert %Ecto.Changeset{} = Scrum.change_phase(phase)
    end
  end

  describe "histories" do
    alias ScrumApp.Scrum.History

    @valid_attrs %{description: "some description", estimate: 120.5, title: "some title"}
    @update_attrs %{description: "some updated description", estimate: 456.7, title: "some updated title"}
    @invalid_attrs %{description: nil, estimate: nil, title: nil}

    def history_fixture(attrs \\ %{}) do
      {:ok, history} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scrum.create_history()

      history
    end

    test "list_histories/0 returns all histories" do
      history = history_fixture()
      assert Scrum.list_histories() == [history]
    end

    test "get_history!/1 returns the history with given id" do
      history = history_fixture()
      assert Scrum.get_history!(history.id) == history
    end

    test "create_history/1 with valid data creates a history" do
      assert {:ok, %History{} = history} = Scrum.create_history(@valid_attrs)
      assert history.description == "some description"
      assert history.estimate == 120.5
      assert history.title == "some title"
    end

    test "create_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scrum.create_history(@invalid_attrs)
    end

    test "update_history/2 with valid data updates the history" do
      history = history_fixture()
      assert {:ok, history} = Scrum.update_history(history, @update_attrs)
      assert %History{} = history
      assert history.description == "some updated description"
      assert history.estimate == 456.7
      assert history.title == "some updated title"
    end

    test "update_history/2 with invalid data returns error changeset" do
      history = history_fixture()
      assert {:error, %Ecto.Changeset{}} = Scrum.update_history(history, @invalid_attrs)
      assert history == Scrum.get_history!(history.id)
    end

    test "delete_history/1 deletes the history" do
      history = history_fixture()
      assert {:ok, %History{}} = Scrum.delete_history(history)
      assert_raise Ecto.NoResultsError, fn -> Scrum.get_history!(history.id) end
    end

    test "change_history/1 returns a history changeset" do
      history = history_fixture()
      assert %Ecto.Changeset{} = Scrum.change_history(history)
    end
  end

  describe "tasks" do
    alias ScrumApp.Scrum.Task

    @valid_attrs %{description: "some description", estimate: 120.5, title: "some title"}
    @update_attrs %{description: "some updated description", estimate: 456.7, title: "some updated title"}
    @invalid_attrs %{description: nil, estimate: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scrum.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Scrum.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Scrum.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Scrum.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.estimate == 120.5
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scrum.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Scrum.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.estimate == 456.7
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Scrum.update_task(task, @invalid_attrs)
      assert task == Scrum.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Scrum.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Scrum.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Scrum.change_task(task)
    end
  end
end
