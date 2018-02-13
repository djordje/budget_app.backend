defmodule BudgetApp.Operations.Income.Delete do
  alias BudgetApp.Income
  alias BudgetApp.Repo

  def exec(income_id) do
    Income
    |> Repo.get(income_id)
    |> Repo.delete
  rescue
    _e -> {:error, "Something went wrong!"}
  end
end