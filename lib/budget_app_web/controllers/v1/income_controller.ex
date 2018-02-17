defmodule BudgetAppWeb.V1.IncomeController do
  use BudgetAppWeb, :controller

  alias BudgetApp.Operations.Income
  alias BudgetApp.Repo

  action_fallback BudgetAppWeb.FallbackController

  def index(conn, %{"page_number" => page_number} = params) do
    page_size = params["page_size"] || 10
    operation = Income.GetPaginated.exec(page_number, page_size)
    with {:ok, paginated} <- operation do
      conn
      |> render("index.json", paginated: paginated)
    end
  end

  def create(conn, %{"income" => %{"on_date" => on_date, "for_date" => for_date, "currency_id" => currency_id, "amount" => amount, "desc" => desc}}) do
    operation = Income.Create.exec(on_date, for_date, currency_id, amount, desc)
    with {:ok, income} <- operation do
      income = Repo.preload(income, :currency)
      conn
      |> put_status(:created)
      |> render("show.json", income: income)
    end
  end

  def update(conn, %{"id" => id, "income" => params}) do
    # TODO: This is potential problem, because Erlang doesn't GC atoms!
    params    = AtomicMap.convert(params, safe: false)
    operation = Income.Update.exec(id, params)
    with {:ok, income} <- operation do
      income = Repo.preload(income, :currency)
      conn
      |> put_status(:accepted)
      |> render("show.json", income: income)
    end
  end

  def delete(conn, %{"id" => id}) do
    operation = Income.Delete.exec(id)
    with {:ok, _} <- operation do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:no_content, "")
    end
  end
end