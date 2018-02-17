defmodule BudgetAppWeb.V1.ExpenseController do
  use BudgetAppWeb, :controller

  alias BudgetApp.Operations.Expense
  alias BudgetApp.Repo

  action_fallback BudgetAppWeb.FallbackController

  def index(conn, %{"page_number" => page_number} = params) do
    page_size = params["page_size"] || 10
    operation = Expense.GetPaginated.exec(page_number, page_size)
    with {:ok, paginated} <- operation do
      conn
      |> render("index.json", paginated: paginated)
    end
  end

  def create(conn, %{"expense" => %{"on_date" => on_date, "currency_id" => currency_id, "amount" => amount, "desc" => desc}}) do
    operation = Expense.Create.exec(on_date, currency_id, amount, desc)
    with {:ok, expense} <- operation do
      expense = Repo.preload(expense, :currency)
      conn
      |> put_status(:created)
      |> render("show.json", expense: expense)
    end
  end

  def update(conn, %{"id" => id, "expense" => params}) do
    # TODO: This is potential problem, because Erlang doesn't GC atoms!
    params    = AtomicMap.convert(params, safe: false)
    operation = Expense.Update.exec(id, params)
    with {:ok, expense} <- operation do
      expense = Repo.preload(expense, :currency)
      conn
      |> put_status(:accepted)
      |> render("show.json", expense: expense)
    end
  end

  def delete(conn, %{"id" => id}) do
    operation = Expense.Delete.exec(id)
    with {:ok, _} <- operation do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:no_content, "")
    end
  end
end