defmodule BudgetAppWeb.V1.APITokenController do
  use BudgetAppWeb, :controller

  action_fallback BudgetAppWeb.FallbackController

  def obtain(conn, %{"email" => email, "password" => password}) do
    with {:ok, api_token} <- BudgetApp.Operations.ObtainAPIToken.exec(email, password) do
      conn
      |> put_status(:created)
      |> render("show.json", api_token: api_token)
    end
  end
end
