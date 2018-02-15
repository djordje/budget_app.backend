defmodule BudgetApp.Operations.Currency.GetPaginated do
  alias BudgetApp.Currency
  alias BudgetApp.Repo

  def exec(page_number, page_size \\ 10)
  def exec(nil, _), do: {:operation_error, "Page number must be a number!"}
  def exec(_, nil), do: {:operation_error, "Page size must be a number!"}

  def exec(page_number, page_size) do
    case fetch_resources(page_number, page_size) do
      %Scrivener.Page{} = paginated -> {:ok, paginated}
      _                             -> {:operation_error, "Something went wrong!"}
    end
  end

  defp fetch_resources(page_number, page_size) do
    Currency
    |> Repo.paginate(page: page_number, page_size: page_size)
  end
end