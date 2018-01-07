defmodule BudgetAppWeb.Router do
  use BudgetAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BudgetAppWeb do
    pipe_through :api
  end
end
