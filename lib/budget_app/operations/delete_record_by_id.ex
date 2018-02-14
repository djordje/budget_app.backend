defmodule BudgetApp.Operations.DeleteRecordById do
  defmacro __using__(opts) do
    alias BudgetApp.Repo
    
    unless opts[:model] do
      raise "`:model` must be defined!"
    end

    quote do
      def exec(record_id) do
        unquote(opts)[:model]
        |> Repo.get(record_id)
        |> Repo.delete
      rescue
        _e -> {:error, "Something went wrong"}
      end
    end
  end
end