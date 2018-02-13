defmodule BudgetApp.Operations.Currency.Create do
  alias BudgetApp.Currency
  alias BudgetApp.Repo

  def exec(nil, _), do: {:operation_error, "Name is required!"}
  def exec(_, nil), do: {:operation_error, "ISO code is required!"}

  def exec(name, iso_code) do
    %Currency{}
    |> Currency.changeset(%{
      name:     name,
      iso_code: iso_code,
    })
    |> Repo.insert
  end
end