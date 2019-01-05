defmodule BudgetAppWeb.V1.ExpenseControllerTest do
  use BudgetAppWeb.APIControllerCase

  describe "index" do
    test "returns paginated collection of expenses", %{conn: conn} do
      expenses = insert_list(5, :expense)
      expense  = Enum.at(expenses, 4)
      res        = get conn, v1_expense_path(conn, :index), page_number: 1
      res_body   = json_response(res, 200)
      assert res_body["data"]
      expected = %{
        "id"       => expense.id,
        "amount"   => expense.amount,
        "on_date"  => NaiveDateTime.to_iso8601(expense.on_date),
        "desc"     => expense.desc,
        "currency" => %{
          "id"       => expense.currency.id,
          "name"     => expense.currency.name,
          "iso_code" => expense.currency.iso_code
        }
      }
      assert expected == Enum.at(res_body["data"], 0)
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      res  = get remove_authorization(conn), v1_expense_path(conn, :index), page_number: 1
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "create" do
    test "returns newly created expense", %{conn: conn} do
      {:ok, date} = Date.new(2018, 2, 17)
      currency = insert(:currency)
      req_body = %{
        expense: %{
          on_date:     date,
          currency_id: currency.id,
          amount:      10,
          desc:        "Test"
        }
      }
      res = post conn, v1_expense_path(conn, :create), req_body
      res_body = json_response(res, 201)
      assert res_body["data"]
      assert %{
        "id"       => _,
        "amount"   => 10.0,
        "on_date"  => _,
        "desc"     => "Test",
        "currency" => %{
          "id"       => _,
          "name"     => _,
          "iso_code" => _
        }
      } = res_body["data"]
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      {:ok, date} = Date.new(2018, 2, 17)
      currency = insert(:currency)
      req_body = %{
        expense: %{
          on_date:     date,
          currency_id: currency.id,
          amount:      10,
          desc:        "Test"
        }
      }
      res = post remove_authorization(conn), v1_expense_path(conn, :create), req_body
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "update" do
    test "returns updated expense", %{conn: conn} do
      expense = insert(:expense, amount: 10.0)
      res = put conn, v1_expense_path(conn, :update, expense.id), %{expense: %{amount: 12.5}}
      res_body = json_response(res, 202)
      assert res_body["data"]
      assert %{
        "id"       => _,
        "amount"   => 12.5,
        "on_date"  => _,
        "desc"     => _,
        "currency" => %{
          "id"       => _,
          "name"     => _,
          "iso_code" => _
        }
      } = res_body["data"]
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      expense = insert(:expense, amount: 10.0)
      res = put remove_authorization(conn), v1_expense_path(conn, :update, expense.id), %{expense: %{amount: 12.5}}
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "delete" do
    test "removes expense", %{conn: conn} do
      expense = insert(:expense)
      res = delete conn, v1_expense_path(conn, :delete, expense.id)
      assert res.status == 204
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      expense = insert(:expense)
      res = delete remove_authorization(conn), v1_expense_path(conn, :delete, expense.id)
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end
end