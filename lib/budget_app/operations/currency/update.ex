defmodule BudgetApp.Operations.Currency.Update do
  use BudgetApp.Operations.UpdateRecordById,
    model: BudgetApp.Currency,
    updatable_fields: [:name, :iso_code],
    resource_id_required: "Currency ID is required!",
    resource_not_found: "Currency not found!"
end