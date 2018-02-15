defmodule BudgetApp.Operations.GetPaginated do

  @callback resource_query(filters :: any) :: %Ecto.Query{}

  defmacro __using__(_opts) do
    quote do

      alias BudgetApp.Operations.GetPaginated, as: GetPaginatedBase
      alias BudgetApp.Repo
      import Ecto.Query

      @behaviour GetPaginatedBase

      def exec(page_number, page_size \\ 10, filters \\ nil)
      def exec(nil, _, _), do: {:operation_error, "Page number must be a number!"}
      def exec(_, nil, _), do: {:operation_error, "Page size must be a number!"}

      def exec(page_number, page_size, filters) do
        res = resource_query(filters)
          |> fetch_paginated(page_number, page_size)
        case res do
          %Scrivener.Page{} = paginated -> {:ok, paginated}
          _                             -> {:operation_error, "Something went wrong!"}
        end
      end

      def fetch_paginated(query, page_number, page_size) do
        Repo.paginate(query, page: page_number, page_size: page_size)
      end

    end
  end

end