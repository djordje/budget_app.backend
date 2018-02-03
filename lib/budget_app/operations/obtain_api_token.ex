defmodule BudgetApp.Operations.ObtainAPIToken do
  alias BudgetApp.APIToken
  alias BudgetApp.User
  alias BudgetApp.Repo

  @error {:error, "Invalid credentials!"}
  @day_in_seconds 24*60*60

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
    params = %{
      user_id:       user.id,
      access_token:  SecureRandom.base64(32),
      refresh_token: SecureRandom.base64(32),
      expires_at:    expires_at()
    }
    api_token = %APIToken{}
      |> APIToken.changeset(params)
      |> Repo.insert
    case api_token do
      {:error, _} -> false
      {_, model}  -> model
    end
  end
  defp create_api_token(_, _), do: false

  defp expires_at(days_ahead \\ 30) do
    expires_in = days_ahead * @day_in_seconds
    now = DateTime.utc_now()
    case DateTime.from_unix(DateTime.to_unix(now) + expires_in) do
      {:ok, datetime} -> datetime
      _               -> now
    end
  end

end