defmodule BudgetApp.Operations.Income.GetPaginated do
  use BudgetApp.Operations.GetPaginated
  alias BudgetApp.Income

  def resource_query(_filters) do
    from i in Income,
      preload: :currency,
      order_by: [desc: i.on_date, desc: i.for_date, desc: i.id]
  end
end