defmodule BudgetAppWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BudgetAppWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(BudgetAppWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(BudgetAppWeb.ErrorView, :"404")
  end

  def call(conn, {:operation_error, message}) do
    conn
    |> put_status(:bad_request)
    |> render(BudgetAppWeb.ErrorView, "400.json", detail: message)
  end
end
