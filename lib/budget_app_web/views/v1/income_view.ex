defmodule BudgetAppWeb.V1.IncomeView do
  use BudgetAppWeb, :view
  alias BudgetAppWeb.V1.IncomeView
  alias BudgetAppWeb.V1.CurrencyView

  def render("index.json", %{paginated: paginated}) do
    %{
      data: render_many(paginated.entries, IncomeView, "income.json"),
      page_number:   paginated.page_number,
      page_size:     paginated.page_size,
      total_entries: paginated.total_entries,
      total_pages:   paginated.total_pages
    }
  end

  def render("show.json", %{income: income}) do
    %{data: render_one(income, IncomeView, "income.json")}
  end

  def render("income.json", %{income: income}) do
    %{
      id:       income.id,
      amount:   income.amount,
      for_date: income.for_date,
      on_date:  income.on_date,
      desc:     income.desc,
      currency: render_one(income.currency, CurrencyView, "currency.json")
    }
  end
end
