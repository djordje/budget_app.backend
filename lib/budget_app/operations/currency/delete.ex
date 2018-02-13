defmodule BudgetApp.Operations.Currency.Delete do
  alias BudgetApp.Currency
  alias BudgetApp.Repo

  def exec(currency_id) do
    Currency
    |> Repo.get(currency_id)
    |> Repo.delete
  rescue
    _e -> {:error, "Something went wrong!"}
  end
end