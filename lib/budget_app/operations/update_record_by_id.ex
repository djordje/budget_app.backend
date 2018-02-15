defmodule BudgetApp.Operations.UpdateRecordById do
  defmacro __using__(opts) do
    alias BudgetApp.Repo
    alias BudgetApp.Components.FilterFields

    unless opts[:model] do
      raise "`:model` must be defined!"
    end

    model                = opts[:model]
    updatable_fields     = opts[:updatable_fields]     || []
    resource_id_required = opts[:resource_id_required] || "Resource ID is required!"
    resource_not_found   = opts[:resource_not_found]   || "Resource not found!"
    no_fields_to_update  = opts[:no_fields_to_update]  || "No fields to update!"

    quote do
      def exec(nil, _), do: {:operation_error, unquote(resource_id_required)}
      def exec(record_id, fields) do
        record = fetch_record(record_id)
        fields = filter_fields(fields)
        update(record, fields)
      end
    
      defp fetch_record(id), do: Repo.get(unquote(model), id)
    
      defp filter_fields(fields) do
        case FilterFields.exec(unquote(updatable_fields), fields) do
          {:ok, fields} -> fields
          _             -> %{}
        end
      end
    
      defp update(nil, _), do: {:operation_error, unquote(resource_not_found)}
      defp update(_, fields) when fields == %{}, do: {:operation_error, unquote(no_fields_to_update)}
      defp update(record, fields) do
        record
        |> unquote(model).changeset(fields)
        |> Repo.update()
      end
    end
  end
end