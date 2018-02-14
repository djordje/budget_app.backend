defmodule BudgetApp.Operations.Currency.Update do
  alias BudgetApp.Currency
  alias BudgetApp.Repo
  alias BudgetApp.Components.FilterFields

  def exec(nil, _), do: {:operation_error, "Currency ID is required!"}
  def exec(currency_id, fields) do
    currency = fetch_currency(currency_id)
    fields   = filter_fields(fields)
    update(currency, fields)
  end

  defp fetch_currency(id), do: Repo.get(Currency, id)

  @updatable_fields [:name, :iso_code]
  defp filter_fields(fields) do
    {:ok, fields} = FilterFields.exec(@updatable_fields, fields)
    fields
  end

  defp update(nil, _), do: {:operation_error, "Currency not found!"}
  defp update(_, fields) when fields == %{}, do: {:operation_error, "No fields to update!"}
  defp update(currency, fields) do
    currency
    |> Currency.changeset(fields)
    |> Repo.update()
  end
end