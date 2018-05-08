defmodule ScrumAppWeb.PhaseControllerTest do
  use ScrumAppWeb.ConnCase

  alias ScrumApp.Scrum
  alias ScrumApp.Scrum.Phase

  @create_attrs %{task_count: 42, title: "some title"}
  @update_attrs %{task_count: 43, title: "some updated title"}
  @invalid_attrs %{task_count: nil, title: nil}

  def fixture(:phase) do
    {:ok, phase} = Scrum.create_phase(@create_attrs)
    phase
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all phases", %{conn: conn} do
      conn = get conn, phase_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create phase" do
    test "renders phase when data is valid", %{conn: conn} do
      conn = post conn, phase_path(conn, :create), phase: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, phase_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "task_count" => 42,
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, phase_path(conn, :create), phase: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update phase" do
    setup [:create_phase]

    test "renders phase when data is valid", %{conn: conn, phase: %Phase{id: id} = phase} do
      conn = put conn, phase_path(conn, :update, phase), phase: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, phase_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "task_count" => 43,
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, phase: phase} do
      conn = put conn, phase_path(conn, :update, phase), phase: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete phase" do
    setup [:create_phase]

    test "deletes chosen phase", %{conn: conn, phase: phase} do
      conn = delete conn, phase_path(conn, :delete, phase)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, phase_path(conn, :show, phase)
      end
    end
  end

  defp create_phase(_) do
    phase = fixture(:phase)
    {:ok, phase: phase}
  end
end
