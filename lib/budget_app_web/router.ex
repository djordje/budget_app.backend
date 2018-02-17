defmodule BudgetAppWeb.Router do
  use BudgetAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BudgetAppWeb.BearerAuthorization
  end

  scope "/v1", BudgetAppWeb.V1, as: :v1 do
    pipe_through :api

    scope "/api_token" do
      post "/obtain", APITokenController, :obtain
      post "/refresh", APITokenController, :refresh
    end
  end

  scope "/v1", BudgetAppWeb.V1, as: :v1 do
    pipe_through [:api, :auth]

    resources "/currencies", CurrenciesController, only: [:index, :create, :update, :delete]
  end
end
