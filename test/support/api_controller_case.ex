defmodule BudgetAppWeb.APIControllerCase do
  use ExUnit.CaseTemplate
  
  using do
    quote do
      use BudgetAppWeb.ConnCase

      setup %{conn: conn} do
        api_token = insert(:api_token)
        conn = conn
          |> put_req_header("accept", "application/json")
          |> put_req_header("authorization", "Bearer #{api_token.access_token}")
        {:ok, conn: conn}
      end

      def remove_authorization(conn) do
        delete_req_header(conn, "authorization")
      end
    end
  end
end