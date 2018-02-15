defmodule BudgetApp.Operations.ExchangeRate.Update do
  use BudgetApp.Operations.UpdateRecordById,
    model: BudgetApp.ExchangeRate,
    updatable_fields: [:on_date, :rate, :from_currency_id, :to_currency_id, :monthly],
    resource_id_required: "Exchange rate ID is required!",
    resource_not_found: "Exchange rate not found!"
end