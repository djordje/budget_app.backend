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
          %Scrivener.Page{} = paginated -> {:ok, empty_if_page_greater_than_total(page_number, paginated)}
          _                             -> {:operation_error, "Something went wrong!"}
        end
      end

      def fetch_paginated(query, page_number, page_size) do
        Repo.paginate(query, page: page_number, page_size: page_size)
      end

      # NOTE (djk):
      #
      # https://github.com/drewolson/scrivener_ecto/blob/master/CHANGELOG.md
      # 2.0.0
      #   * Don't allow page_number to be greater than total_pages
      #   * Support Ecto 3.0
      #
      # This makes API the same as it used to be and returns empty list unless page exists.
      # Otherwise it returns last present page!

      defp empty_if_page_greater_than_total(page_number, paginated) when is_binary(page_number) do
        page_number
        |> String.to_integer
        |> empty_if_page_greater_than_total(paginated)
      end

      defp empty_if_page_greater_than_total(page_number, paginated) do
        if page_number > paginated.page_number do
          Map.merge(paginated, %{
            entries: [],
            page_number: page_number
          })
        else
          paginated
        end
      end

    end
  end

end