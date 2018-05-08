defmodule ScrumAppWeb.Router do
  use ScrumAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", ScrumAppWeb do
    pipe_through :api
    
    resources "/projects", ProjectController, except: [:new, :edit]
    resources "/sprints", SprintController, except: [:new, :edit]
    resources "/phases", PhaseController, except: [:new, :edit]
    resources "/histories", HistoryController, except: [:new, :edit]
    resources "/tasks", TaskController, except: [:new, :edit]
  end

  scope "/", ScrumAppWeb do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
