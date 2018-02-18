defmodule BudgetAppWeb.V1.ExchangeRateController do
  use BudgetAppWeb, :controller

  alias BudgetApp.Operations.ExchangeRate
  alias BudgetApp.Repo

  action_fallback BudgetAppWeb.FallbackController

  def create(conn, %{"exchange_rate" => %{
    "monthly" => monthly,
    "on_date" => on_date,
    "rate" => rate,
    "from_currency_id" => from_currency_id, 
    "to_currency_id" => to_currency_id
  }}) do
    operation = ExchangeRate.Create.exec(on_date, rate, from_currency_id, to_currency_id, monthly)
    with {:ok, exchange_rate} <- operation do
      exchange_rate = Repo.preload(exchange_rate, [:from_currency, :to_currency])
      conn
      |> put_status(:created)
      |> render("show.json", exchange_rate: exchange_rate)
    end
  end

  def update(conn, %{"id" => id, "exchange_rate" => params}) do
    # TODO: This is potential problem, because Erlang doesn't GC atoms!
    params    = AtomicMap.convert(params, safe: false)
    operation = ExchangeRate.Update.exec(id, params)
    with {:ok, exchange_rate} <- operation do
      exchange_rate = Repo.preload(exchange_rate, [:from_currency, :to_currency])
      conn
      |> put_status(:accepted)
      |> render("show.json", exchange_rate: exchange_rate)
    end
  end

  def delete(conn, %{"id" => id}) do
    operation = ExchangeRate.Delete.exec(id)
    with {:ok, _} <- operation do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:no_content, "")
    end
  end
end