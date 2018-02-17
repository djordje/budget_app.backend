defmodule BudgetAppWeb.V1.ExpenseView do
  use BudgetAppWeb, :view
  alias BudgetAppWeb.V1.ExpenseView
  alias BudgetAppWeb.V1.CurrenciesView

  def render("index.json", %{paginated: paginated}) do
    %{
      data: render_many(paginated.entries, ExpenseView, "expense.json"),
      page_number:   paginated.page_number,
      page_size:     paginated.page_size,
      total_entries: paginated.total_entries,
      total_pages:   paginated.total_pages
    }
  end

  def render("show.json", %{expense: expense}) do
    %{data: render_one(expense, ExpenseView, "expense.json")}
  end

  def render("expense.json", %{expense: expense}) do
    %{
      id: expense.id,
      amount: expense.amount,
      on_date: expense.on_date,
      desc: expense.desc,
      currency: render_one(expense.currency, CurrenciesView, "currency.json", as: :currency)
    }
  end
end
