defmodule BudgetApp.Operations.ExchangeRate.Delete do
  alias BudgetApp.ExchangeRate
  alias BudgetApp.Repo

  def exec(exchange_rate_id) do
    ExchangeRate
    |> Repo.get(exchange_rate_id)
    |> Repo.delete
  rescue
    _e -> {:error, "Something went wrong!"}
  end
end