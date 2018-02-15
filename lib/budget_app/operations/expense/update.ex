defmodule BudgetApp.Operations.Expense.Update do
  use BudgetApp.Operations.UpdateRecordById,
    model: BudgetApp.Expense,
    updatable_fields: [:on_date, :currency_id, :amount, :desc],
    resource_id_required: "Expense ID is required!",
    resource_not_found: "Expense not found!"
end