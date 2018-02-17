defmodule BudgetAppWeb.V1.CurrencyController do
  use BudgetAppWeb, :controller

  alias BudgetApp.Operations.Currency

  action_fallback BudgetAppWeb.FallbackController

  def index(conn, %{"page_number" => page_number} = params) do
    page_size = params["page_size"] || 10
    operation = Currency.GetPaginated.exec(page_number, page_size)
    with {:ok, paginated} <- operation do
      conn
      |> render("index.json", paginated: paginated)
    end
  end

  def create(conn, %{"currency" => %{"name" => name, "iso_code" => iso_code}}) do
    operation = Currency.Create.exec(name, iso_code)
    with {:ok, currency} <- operation do
      conn
      |> put_status(:created)
      |> render("show.json", currency: currency)
    end
  end

  def update(conn, %{"id" => id, "currency" => params}) do
    # TODO: This is potential problem, because Erlang doesn't GC atoms!
    params    = AtomicMap.convert(params, safe: false)
    operation = Currency.Update.exec(id, params)
    with {:ok, currency} <- operation do
      conn
      |> put_status(:accepted)
      |> render("show.json", currency: currency)
    end
  end

  def delete(conn, %{"id" => id}) do
    operation = Currency.Delete.exec(id)
    with {:ok, _} <- operation do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:no_content, "")
    end
  end
end