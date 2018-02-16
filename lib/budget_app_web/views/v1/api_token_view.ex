defmodule BudgetAppWeb.V1.APITokenView do
  use BudgetAppWeb, :view
  alias BudgetAppWeb.V1.APITokenView

  def render("show.json", %{api_token: api_token}) do
    %{data: render_one(api_token, APITokenView, "api_token.json")}
  end

  def render("api_token.json", %{api_token: api_token}) do
    %{
      access_token: api_token.access_token,
      refresh_token: api_token.refresh_token,
      expires_at: api_token.expires_at
    }
  end
end
