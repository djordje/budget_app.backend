defmodule BudgetAppWeb.V1.APITokenControllerTest do
  use BudgetAppWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "obtain" do
    test "obtains fresh access and refresh tokens", %{conn: conn} do
      user = insert(:user)
      conn = post conn, v1_api_token_path(conn, :obtain), email: user.email, password: "1234"
      assert json_response(conn, 201)["data"]
    end

    test "respond with error unless user credentials are correct", %{conn: conn} do
      conn = post conn, v1_api_token_path(conn, :obtain), email: "invalid@example.com", password: "1234"
      assert json_response(conn, 400)["errors"]
    end
  end

  describe "refresh" do
    test "creates new access and refresh tokens and remove old pair", %{conn: conn} do
      api_token = insert(:api_token)
      conn = post conn,
        v1_api_token_path(conn, :refresh),
        access_token: api_token.access_token, refresh_token: api_token.refresh_token
      assert json_response(conn, 201)["data"]
    end

    test "respond with error unless access and refresh tokens given", %{conn: conn} do
      conn = post conn, v1_api_token_path(conn, :refresh), access_token: nil, refresh_token: "1234"
      assert json_response(conn, 400)["errors"]
    end

    test "respond with error unless api token record found", %{conn: conn} do
      conn = post conn, v1_api_token_path(conn, :refresh), access_token: "1234", refresh_token: "1234"
      assert json_response(conn, 400)["errors"]
    end
  end
end
