defmodule BudgetApp.Operations.RefreshAPIToken do
  alias BudgetApp.APIToken
  alias BudgetApp.Repo

  @error {:error, "Invalid credentials!"}

  def exec(access_token, _) when access_token in ["", nil], do: @error
  def exec(_, refresh_token) when refresh_token in ["", nil], do: @error

  def exec(access_token, refresh_token) do
    api_token = fetch_api_token(access_token)
    case check_refresh_token(api_token, refresh_token)
      |> create_api_token(api_token)
      |> remove_old_api_token(api_token) do
        false         -> @error
        new_api_token -> {:ok, new_api_token}
      end
  end

  defp fetch_api_token(access_token), do: Repo.get_by(APIToken, access_token: access_token)

  defp check_refresh_token(%APIToken{} = api_token, refresh_token) do
    api_token.refresh_token == refresh_token
  end
  defp check_refresh_token(_, _), do: false

  defp create_api_token(true, %APIToken{} = api_token) do
    case BudgetApp.Operations.APIToken.Create.exec(api_token.user_id) do
      {:error, _}      -> false
      {:ok, api_token} -> api_token
    end
  end
  defp create_api_token(_, _), do: false

  defp remove_old_api_token(%APIToken{} = new_api_token, %APIToken{} = api_token) do
    case Repo.delete(api_token) do
      {:ok, _} -> new_api_token
      _        -> false
    end
  end
  defp remove_old_api_token(_, _), do: false

end