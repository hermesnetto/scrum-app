defmodule ScrumAppWeb.SprintControllerTest do
  use ScrumAppWeb.ConnCase

  alias ScrumApp.Scrum
  alias ScrumApp.Scrum.Sprint

  @create_attrs %{end_date: ~D[2010-04-17], finished: true, init_date: ~D[2010-04-17]}
  @update_attrs %{end_date: ~D[2011-05-18], finished: false, init_date: ~D[2011-05-18]}
  @invalid_attrs %{end_date: nil, finished: nil, init_date: nil}

  def fixture(:sprint) do
    {:ok, sprint} = Scrum.create_sprint(@create_attrs)
    sprint
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sprints", %{conn: conn} do
      conn = get conn, sprint_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sprint" do
    test "renders sprint when data is valid", %{conn: conn} do
      conn = post conn, sprint_path(conn, :create), sprint: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, sprint_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_date" => ~D[2010-04-17],
        "finished" => true,
        "init_date" => ~D[2010-04-17]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, sprint_path(conn, :create), sprint: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sprint" do
    setup [:create_sprint]

    test "renders sprint when data is valid", %{conn: conn, sprint: %Sprint{id: id} = sprint} do
      conn = put conn, sprint_path(conn, :update, sprint), sprint: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, sprint_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_date" => ~D[2011-05-18],
        "finished" => false,
        "init_date" => ~D[2011-05-18]}
    end

    test "renders errors when data is invalid", %{conn: conn, sprint: sprint} do
      conn = put conn, sprint_path(conn, :update, sprint), sprint: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sprint" do
    setup [:create_sprint]

    test "deletes chosen sprint", %{conn: conn, sprint: sprint} do
      conn = delete conn, sprint_path(conn, :delete, sprint)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, sprint_path(conn, :show, sprint)
      end
    end
  end

  defp create_sprint(_) do
    sprint = fixture(:sprint)
    {:ok, sprint: sprint}
  end
end
