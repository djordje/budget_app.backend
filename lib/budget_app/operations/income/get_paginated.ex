defmodule BudgetApp.Operations.Income.GetPaginated do
  use BudgetApp.Operations.GetPaginated
  alias BudgetApp.Income

  def resource_query(_filters) do
    from i in Income,
      preload: :currency
  end
end