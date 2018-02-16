defmodule BudgetApp.Operations.ObtainAPIToken do
  alias BudgetApp.User
  alias BudgetApp.Repo

  @error {:operation_error, "Invalid credentials!"}

  def exec(email, _) when email in ["", nil], do: @error
  def exec(_, password) when password in ["", nil], do: @error

  def exec(email, password) do
    user = fetch_user(email)
    case check_password(user, password) |> create_api_token(user) do
      false     -> @error
      api_token -> {:ok, api_token}
    end
  end

  defp fetch_user(email), do: Repo.get_by(User, email: email)

  defp check_password(%User{} = user, password), do: Comeonin.Argon2.checkpw(password, user.secret)
  defp check_password(_, _), do: false

  defp create_api_token(true, %User{} = user) do
    case BudgetApp.Operations.APIToken.Create.exec(user.id) do
      {:error, _}      -> false
      {:ok, api_token} -> api_token
    end
  end
  defp create_api_token(_, _), do: false

end