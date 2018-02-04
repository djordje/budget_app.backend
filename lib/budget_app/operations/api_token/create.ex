defmodule BudgetApp.Operations.APIToken.Create do
  alias BudgetApp.APIToken
  alias BudgetApp.Repo

  def exec(user_id, days_to_expiration \\ 30) do
    %APIToken{}
    |> APIToken.changeset(%{
      user_id:       user_id,
      access_token:  SecureRandom.base64(32),
      refresh_token: SecureRandom.base64(32),
      expires_at:    Timex.now |> Timex.shift(days: days_to_expiration)
    })
    |> Repo.insert
  end
  
end