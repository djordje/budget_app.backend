defmodule BudgetAppWeb.V1.ExchangeRateView do
  use BudgetAppWeb, :view
  alias BudgetAppWeb.V1.ExchangeRateView
  alias BudgetAppWeb.V1.CurrencyView

  def render("show.json", %{exchange_rate: exchange_rate}) do
    %{data: render_one(exchange_rate, ExchangeRateView, "exchange_rate.json")}
  end

  def render("exchange_rate.json", %{exchange_rate: exchange_rate}) do
    %{
      id:            exchange_rate.id,
      monthly:       exchange_rate.monthly,
      on_date:       exchange_rate.on_date,
      rate:          exchange_rate.rate,
      from_currency: render_one(exchange_rate.from_currency, CurrencyView, "currency.json"),
      to_currency:   render_one(exchange_rate.to_currency, CurrencyView, "currency.json")
    }
  end
end
