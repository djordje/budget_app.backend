defmodule BudgetAppWeb.V1.ExchangeRateControllerTest do
  use BudgetAppWeb.APIControllerCase

  describe "create" do
    test "returns newly created exchange rate", %{conn: conn} do
      {:ok, date} = Date.new(2018, 2, 17)
      from_currency = insert(:currency, name: "Euro", iso_code: "EUR")
      to_currency   = insert(:currency, name: "Serbian dinar", iso_code: "RSD")
      req_body = %{
        exchange_rate: %{
          monthly:          true,
          on_date:          date,
          rate:             118.8,
          from_currency_id: from_currency.id,
          to_currency_id:   to_currency.id
        }
      }
      res = post conn, v1_exchange_rate_path(conn, :create), req_body
      res_body = json_response(res, 201)
      assert res_body["data"]
      assert %{
        "id"       => _,
        "monthly"  => true,
        "on_date"  => _,
        "rate"     => 118.8,
        "from_currency" => %{
          "id"       => _,
          "name"     => _,
          "iso_code" => _
        },
        "to_currency" => %{
          "id"       => _,
          "name"     => _,
          "iso_code" => _
        }
      } = res_body["data"]
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      {:ok, date} = Date.new(2018, 2, 17)
      from_currency = insert(:currency, name: "Euro", iso_code: "EUR")
      to_currency   = insert(:currency, name: "Serbian dinar", iso_code: "RSD")
      req_body = %{
        exchange_rate: %{
          monthly:          true,
          on_date:          date,
          rate:             118.8,
          from_currency_id: from_currency.id,
          to_currency_id:   to_currency.id
        }
      }
      res = post remove_authorization(conn), v1_exchange_rate_path(conn, :create), req_body
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "update" do
    test "returns updated exchange rate", %{conn: conn} do
      exchange_rate = insert(:exchange_rate, rate: 10.0)
      res = put conn, v1_exchange_rate_path(conn, :update, exchange_rate.id), %{exchange_rate: %{rate: 17.2}}
      res_body = json_response(res, 202)
      assert res_body["data"]
      assert %{
        "id"       => _,
        "monthly"  => _,
        "on_date"  => _,
        "rate"     => 17.2,
        "from_currency" => %{
          "id"       => _,
          "name"     => _,
          "iso_code" => _
        },
        "to_currency" => %{
          "id"       => _,
          "name"     => _,
          "iso_code" => _
        }
      } = res_body["data"]
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      exchange_rate = insert(:exchange_rate)
      res = put remove_authorization(conn), v1_exchange_rate_path(conn, :update, exchange_rate.id), %{exchange_rate: %{rate: 12.5}}
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end

  describe "delete" do
    test "removes exchange rate", %{conn: conn} do
      exchange_rate = insert(:exchange_rate)
      res = delete conn, v1_exchange_rate_path(conn, :delete, exchange_rate.id)
      assert res.status == 204
    end

    test "returns unauthorized unless access token given and valid", %{conn: conn} do
      exchange_rate = insert(:exchange_rate)
      res = delete remove_authorization(conn), v1_exchange_rate_path(conn, :delete, exchange_rate.id)
      res_body = json_response(res, 401)
      assert res_body["error"]
      refute res_body["data"]
    end
  end
end