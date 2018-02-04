defmodule BudgetApp.Operations.Expense.Delete do
  alias BudgetApp.Expense
  alias BudgetApp.Repo

  def exec(expense_id) do
    Expense
    |> Repo.get(expense_id)
    |> Repo.delete
  rescue
    _e -> {:error, "Something went wrong!"}
  end
end