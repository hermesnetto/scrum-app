defmodule ScrumAppWeb.HistoryView do
  use ScrumAppWeb, :view
  alias ScrumAppWeb.HistoryView

  def render("index.json", %{histories: histories}) do
    %{data: render_many(histories, HistoryView, "history.json")}
  end

  def render("show.json", %{history: history}) do
    %{data: render_one(history, HistoryView, "history.json")}
  end

  def render("history.json", %{history: history}) do
    %{id: history.id,
      title: history.title,
      description: history.description,
      estimate: history.estimate}
  end
end
