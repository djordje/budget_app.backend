defmodule BudgetAppWeb.V1.CurrenciesView do
  use BudgetAppWeb, :view
  alias BudgetAppWeb.V1.CurrenciesView

  def render("index.json", %{paginated: paginated}) do
    %{
      data: render_many(paginated.entries, CurrenciesView, "currency.json", as: :currency),
      page_number:   paginated.page_number,
      page_size:     paginated.page_size,
      total_entries: paginated.total_entries,
      total_pages:   paginated.total_pages
    }
  end

  def render("show.json", %{currency: currency}) do
    %{data: render_one(currency, CurrenciesView, "currency.json", as: :currency)}
  end

  def render("currency.json", %{currency: currency}) do
    %{
      id: currency.id,
      name: currency.name,
      iso_code: currency.iso_code
    }
  end
end
