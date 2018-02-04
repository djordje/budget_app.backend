defmodule BudgetApp.Operations.AddExpense do
  alias BudgetApp.Expense
  alias BudgetApp.Repo

  def exec(nil, _, _, _), do: {:error, "Date is required!"}
  def exec(_, nil, _, _), do: {:error, "Currency is required!"}
  def exec(_, _, nil, _), do: {:error, "Amount is required!"}

  def exec(%Date{} = on_date, currency_id, amount, desc) do
    exec(Timex.to_datetime(on_date), currency_id, amount, desc)
  end

  def exec(%DateTime{} = on_date, currency_id, amount, desc) do
    %Expense{}
    |> Expense.changeset(%{
      amount:      amount,
      desc:        desc,
      on_date:     on_date,
      currency_id: currency_id
    })
    |> Repo.insert
  end
end