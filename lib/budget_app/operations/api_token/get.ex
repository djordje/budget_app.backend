defmodule BudgetApp.Operations.APIToken.Get do
  alias BudgetApp.APIToken
  alias BudgetApp.Repo
  import Ecto.Query

  def exec(access_token, preload_user \\ false)
  def exec(nil, _), do: {:operation_error, "Access token is required!"}
  def exec(access_token, preload_user) do
    case valid_api_token(access_token, preload_user) do
      %APIToken{} = api_token -> {:ok, api_token}
      _                       -> {:operation_error, "Invalid or expired access token!"}
    end
  end

  defp valid_api_token(access_token, preload_user) do
    preload = if preload_user, do: [:user], else: []
    query = from at in APIToken,
      where: at.access_token == ^access_token and at.expires_at >= ^Timex.now,
      preload: ^preload
    Repo.one(query)
  end
end