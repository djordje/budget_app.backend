defmodule BudgetApp.Factories do
  use ExMachina.Ecto, repo: BudgetApp.Repo

  def user_factory do
    %BudgetApp.User{
      email:  sequence(:email, &"email-#{&1}@example.com"),
      secret: Comeonin.Argon2.hashpwsalt("1234")
    }
  end

  def api_token_factory do
    %BudgetApp.APIToken{
      access_token:  sequence(:access_token, &"access_token_#{&1}"),
      refresh_token: sequence(:refresh_token, &"refresh_token_#{&1}"),
      expires_at:    Timex.now |> Timex.shift(days: 30),
      user:          build(:user)
    }
  end

  def expense_factory do
    %BudgetApp.Expense{
      amount:   10,
      desc:     "test",
      on_date:  Timex.now,
      currency: build(:currency)
    }
  end

  def currency_factory do
    %BudgetApp.Currency{
      iso_code: sequence(:iso_code, &"TS#{&1}"),
      name:     sequence(:name, &"test #{&1}")
    }
  end
end