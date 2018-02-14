defmodule BudgetApp.Operations.Expense.Delete do
  use BudgetApp.Operations.DeleteRecordById, model: BudgetApp.Expense
end