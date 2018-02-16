defmodule BudgetAppWeb.Router do
  use BudgetAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", BudgetAppWeb.V1, as: :v1 do
    pipe_through :api

    scope "/api_token" do
      post "/obtain", APITokenController, :obtain
      post "/refresh", APITokenController, :refresh
    end
  end
end
