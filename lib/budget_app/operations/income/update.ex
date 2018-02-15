defmodule BudgetApp.Operations.Income.Update do
  use BudgetApp.Operations.UpdateRecordById,
    model: BudgetApp.Income,
    updatable_fields: [:on_date, :for_date, :currency_id, :amount, :desc],
    resource_id_required: "Income ID is required!",
    resource_not_found: "Income not found!"
end