defmodule BudgetAppWeb.V1.APITokenController do
  use BudgetAppWeb, :controller

  alias BudgetApp.Operations.ObtainAPIToken
  alias BudgetApp.Operations.RefreshAPIToken

  action_fallback BudgetAppWeb.FallbackController

  def obtain(conn, %{"email" => email, "password" => password}) do
    with {:ok, api_token} <- ObtainAPIToken.exec(email, password) do
      conn
      |> put_status(:created)
      |> render("show.json", api_token: api_token)
    end
  end

  def refresh(conn, %{"access_token" => access_token, "refresh_token" => refresh_token}) do
    with {:ok, api_token} <- RefreshAPIToken.exec(access_token, refresh_token) do
      conn
      |> put_status(:created)
      |> render("show.json", api_token: api_token)
    end
  end
end
