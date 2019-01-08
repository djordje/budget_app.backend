defmodule BudgetAppWeb.V1.IncomeControllerTest do
  use BudgetAppWeb.APIControllerCase

  describe "index" do
    test "returns paginated collection of incomes", %{conn: conn} do
      incomes  = insert_list(5, :income)
      income   = Enum.at(incomes, 4)
      res      = get conn, v1_income_path(conn, :index), page_number: 1
      res_body = json_response(res, 200)
      assert res_body["data"]
      expected = %{
        "id"       => income.id,
        "amount"   => income.amount,
        "desc"     => income.desc,
        "for_date" => NaiveDateTime.to_iso8601(income.for_date),
        "on_date"  => NaiveDateTime.to_iso8601(income.on_date),
        "currency" => %{
          "id"       => income.currency.id,
          "name"     => income.currency.name,
          "iso_code" => income.currency.iso_code
        }
      }
      assert expected == Enum.at(res_body["data"], 0)
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      res      = get remove_authorization(conn), v1_income_path(conn, :index), page_number: 1
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "create" do
    test "returns newly created income", %{conn: conn} do
      {:ok, date} = Date.new(2018, 2, 17)
      currency = insert(:currency)
      req_body = %{
        income: %{
          on_date:     date,
          for_date:    date,
          currency_id: currency.id,
          amount:      10,
          desc:        "Test"
        }
      }
      res = post conn, v1_income_path(conn, :create), req_body
      res_body = json_response(res, 201)
      assert res_body["data"]
      assert %{
        "id"       => _,
        "amount"   => 10.0,
        "on_date"  => _,
        "for_date" => _,
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
        income: %{
          on_date:     date,
          for_date:    date,
          currency_id: currency.id,
          amount:      10,
          desc:        "Test"
        }
      }
      res = post remove_authorization(conn), v1_income_path(conn, :create), req_body
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "update" do
    test "returns updated income", %{conn: conn} do
      income = insert(:income, amount: 10.0)
      res = put conn, v1_income_path(conn, :update, income.id), %{income: %{amount: 12.5}}
      res_body = json_response(res, 202)
      assert res_body["data"]
      assert %{
        "id"       => _,
        "amount"   => 12.5,
        "for_date" => _,
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
      income = insert(:income, amount: 10.0)
      res = put remove_authorization(conn), v1_income_path(conn, :update, income.id), %{expense: %{amount: 12.5}}
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "delete" do
    test "removes income", %{conn: conn} do
      income = insert(:income)
      res = delete conn, v1_income_path(conn, :delete, income.id)
      assert res.status == 204
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      income = insert(:income)
      res = delete remove_authorization(conn), v1_income_path(conn, :delete, income.id)
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end
end