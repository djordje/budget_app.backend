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
end
