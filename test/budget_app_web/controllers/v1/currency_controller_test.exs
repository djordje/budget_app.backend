defmodule BudgetAppWeb.V1.CurrenciyControllerTest do
  use BudgetAppWeb.APIControllerCase

  describe "index" do
    test "returns paginated collection of currencies", %{conn: conn} do
      currencies = insert_list(5, :currency)
      currency   = Enum.at(currencies, 0)
      res        = get conn, v1_currency_path(conn, :index), page_number: 1
      res_body   = json_response(res, 200)
      assert res_body["data"]
      assert %{"id" => currency.id, "name" => currency.name, "iso_code" => currency.iso_code} == Enum.at(res_body["data"], 0)
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      res  = get remove_authorization(conn), v1_currency_path(conn, :index), page_number: 1
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "create" do
    test "returns newly created currency", %{conn: conn} do
      res = post conn, v1_currency_path(conn, :create), %{currency: %{name: "Serbian dinar", iso_code: "RSD"}}
      res_body = json_response(res, 201)
      assert res_body["data"]
      assert %{"id" => _, "name" => "Serbian dinar", "iso_code" => "RSD"} = res_body["data"]
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      res = post remove_authorization(conn),
              v1_currency_path(conn, :create),
              %{currency: %{name: "Serbian dinar", iso_code: "RSD"}}
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "update" do
    test "returns updated currency", %{conn: conn} do
      currency = insert(:currency, name: "Example", iso_code: "EXS")
      res = put conn, v1_currency_path(conn, :update, currency.id), %{currency: %{iso_code: "EXP"}}
      res_body = json_response(res, 202)
      assert res_body["data"]
      assert %{"id" => currency.id, "name" => currency.name, "iso_code" => "EXP"} == res_body["data"]
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      currency = insert(:currency)
      res = put remove_authorization(conn), v1_currency_path(conn, :update, currency.id), %{currency: %{iso_code: "EXP"}}
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "delete" do
    test "removes currency", %{conn: conn} do
      currency = insert(:currency)
      res = delete conn, v1_currency_path(conn, :delete, currency.id)
      assert res.status == 204
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      currency = insert(:currency)
      res = delete remove_authorization(conn), v1_currency_path(conn, :delete, currency.id)
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end
end