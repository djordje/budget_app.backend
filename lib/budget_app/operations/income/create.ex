defmodule BudgetApp.Operations.Income.Create do
  alias BudgetApp.Income
  alias BudgetApp.Repo

  def exec(nil, _, _, _, _), do: {:operation_error, "Date is required!"}
  def exec(_, nil, _, _, _), do: {:operation_error, "Date is required!"}
  def exec(_, _, nil, _, _), do: {:operation_error, "Currency is required!"}
  def exec(_, _, _, nil, _), do: {:operation_error, "Amount is required!"}

  def exec(%Date{} = on_date, for_date, currency_id, amount, desc) do
    exec(Timex.to_datetime(on_date), for_date, currency_id, amount, desc)
  end

  def exec(on_date, %Date{} = for_date, currency_id, amount, desc) do
    exec(on_date, Timex.to_datetime(for_date), currency_id, amount, desc)
  end

  def exec(on_date, for_date, currency_id, amount, desc) do
    %Income{}
    |> Income.changeset(%{
      on_date:     on_date,
      for_date:    for_date,
      currency_id: currency_id,
      amount:      amount,
      desc:        desc
    })
    |> Repo.insert
  end
end