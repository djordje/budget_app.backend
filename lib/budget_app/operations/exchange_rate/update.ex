defmodule BudgetApp.Operations.ExchangeRate.Update do
  alias BudgetApp.ExchangeRate
  alias BudgetApp.Repo
  alias BudgetApp.Components.FilterFields

  def exec(nil, _), do: {:operation_error, "Exchange rate ID is required!"}
  def exec(exchange_rate_id, fields) do
    exchange_rate = fetch_exchange_rate(exchange_rate_id)
    fields        = filter_fields(fields)
    update(exchange_rate, fields)
  end

  defp fetch_exchange_rate(id), do: Repo.get(ExchangeRate, id)

  @updatable_fields [:on_date, :rate, :from_currency_id, :to_currency_id, :monthly]
  defp filter_fields(fields) do
    {:ok, fields} = FilterFields.exec(@updatable_fields, fields)
    fields
  end

  defp update(nil, _), do: {:operation_error, "Exchange rate not found!"}
  defp update(_, fields) when fields == %{}, do: {:operation_error, "No fields to update!"}
  defp update(exchange_rate, fields) do
    exchange_rate
    |> ExchangeRate.changeset(fields)
    |> Repo.update()
  end
end