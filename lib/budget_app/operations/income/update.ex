defmodule BudgetApp.Operations.Income.Update do
  alias BudgetApp.Income
  alias BudgetApp.Repo

  def exec(nil, _), do: {:operation_error, "Income ID is required!"}
  def exec(income_id, fields) do
    income  = fetch_income(income_id)
    fields  = filter_fields(fields)
    update(income, fields)
  end

  defp fetch_income(id), do: Repo.get(Income, id)

  @updatable_fields [:on_date, :for_date, :currency_id, :amount, :desc]
  defp filter_fields(fields) do
    fields
    |> Enum.into(%{})
    |> Map.take(@updatable_fields)
  end

  defp update(nil, _), do: {:operation_error, "Income not found!"}
  defp update(_, fields) when fields == %{}, do: {:operation_error, "No fields to update!"}
  defp update(income, fields) do
    income
    |> Income.changeset(fields)
    |> Repo.update()
  end
end