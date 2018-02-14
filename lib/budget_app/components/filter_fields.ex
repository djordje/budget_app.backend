defmodule BudgetApp.Components.FilterFields do
  def exec(fields_to_get, map) when is_list(fields_to_get) and is_list(map) do
    map = Enum.into(map, %{})
    exec(fields_to_get, map)
  end

  def exec(fields_to_get, map) when is_list(fields_to_get) and is_map(map) do
    {:ok, Map.take(map, fields_to_get)}
  end

  def exec(_, _), do: {:error, "`fields_to_get` not a list or `map` not a list or map"}
end