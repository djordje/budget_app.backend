defmodule BudgetApp.Operations.Expense.GetPaginated do
  use BudgetApp.Operations.GetPaginated
  alias BudgetApp.Expense

  def resource_query(_filters) do
    from e in Expense,
      preload: :currency
  end
end