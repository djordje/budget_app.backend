defmodule BudgetAppWeb.BearerAuthorization do
  import Plug.Conn

  alias BudgetApp.Operations.APIToken.Get

  def init(opts), do: opts

  def call(conn, _assigns) do
    access_token = case get_req_header(conn, "authorization") do
      ["Bearer " <> access_token] -> access_token
      _                           -> nil
    end
    case Get.exec(access_token) do
      {:ok, _api_token} -> conn
      _                 -> send_unauthorized_response(conn)
    end
  end
  
  defp send_unauthorized_response(conn) do
    body = Poison.encode!(%{error: "Invalid or missing credentials"})
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
    |> halt()
  end
end