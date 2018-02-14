defmodule BudgetApp.Operations.ExchangeRate.Create do
  alias BudgetApp.ExchangeRate
  alias BudgetApp.Repo

  def exec(on_date, rate, from_currency_id, to_currency_id, monthly \\ true)

  def exec(nil, _, _, _, _), do: {:operation_error, "Date is required!"}
  def exec(_, nil, _, _, _), do: {:operation_error, "Rate is required!"}
  def exec(_, _, nil, _, _), do: {:operation_error, "Currency is required!"}
  def exec(_, _, _, nil, _), do: {:operation_error, "Currency is required!"}

  def exec(%Date{} = on_date, rate, from_currency_id, to_currency_id, monthly) do
    exec(Timex.to_datetime(on_date), rate, from_currency_id, to_currency_id, monthly)
  end

  def exec(on_date, rate, from_currency_id, to_currency_id, monthly) do
    %ExchangeRate{}
    |> ExchangeRate.changeset(%{
      on_date:          on_date,
      rate:             rate,
      from_currency_id: from_currency_id,
      to_currency_id:   to_currency_id,
      monthly:          monthly
    })
    |> Repo.insert
  end
end