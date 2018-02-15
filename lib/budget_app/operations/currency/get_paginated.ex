defmodule BudgetApp.Operations.Currency.GetPaginated do
  use BudgetApp.Operations.GetPaginated
  alias BudgetApp.Currency

  def resource_query(_filters), do: Currency
end