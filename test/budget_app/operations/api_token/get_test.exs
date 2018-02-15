defmodule BudgetApp.Operations.APIToken.GetTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.APIToken.Get
  alias BudgetApp.APIToken

  test "gets valid APIToken with user preloaded by access token" do
    api_token = insert(:api_token)
    {:ok, %APIToken{} = token} = Get.exec(api_token.access_token, true)
    assert token == api_token
  end

  test "gets valid APIToken withour user preloaded by access token" do
    api_token = insert(:api_token)
    {:ok, %APIToken{} = token} = Get.exec(api_token.access_token)
    assert token.id == api_token.id
    refute Ecto.assoc_loaded?(token.user)
  end

  test "doesn't get expired APIToken" do
    api_token = insert(:api_token, expires_at: Timex.now |> Timex.shift(days: -1))
    expected  = {:operation_error, "Invalid or expired access token!"}
    assert expected == Get.exec(api_token.access_token)
  end

  test "doesn't get APIToken with invalid access token" do
    expected = {:operation_error, "Invalid or expired access token!"}
    assert expected == Get.exec("invalidToken")
  end

  test "returns error unless access token given" do
    expected  = {:operation_error, "Access token is required!"}
    assert expected == Get.exec(nil)
  end
end