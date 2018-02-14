defmodule BudgetApp.Operations.Expense.Update do
  alias BudgetApp.Expense
  alias BudgetApp.Repo
  alias BudgetApp.Components.FilterFields

  def exec(nil, _), do: {:operation_error, "Expense ID is required!"}
  def exec(expense_id, fields) do
    expense = fetch_expense(expense_id)
    fields  = filter_fields(fields)
    update(expense, fields)
  end

  defp fetch_expense(id), do: Repo.get(Expense, id)

  @updatable_fields [:on_date, :currency_id, :amount, :desc]
  defp filter_fields(fields) do
    {:ok, fields} = FilterFields.exec(@updatable_fields, fields)
    fields
  end

  defp update(nil, _), do: {:operation_error, "Expense not found!"}
  defp update(_, fields) when fields == %{}, do: {:operation_error, "No fields to update!"}
  defp update(expense, fields) do
    expense
    |> Expense.changeset(fields)
    |> Repo.update()
  end
end