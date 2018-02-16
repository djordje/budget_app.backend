defmodule BudgetApp.Operations.RefreshAPITokenTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.RefreshAPIToken
  alias BudgetApp.APIToken
  alias BudgetApp.Repo

  test "removes old token and creates new one" do
    api_token = insert(:api_token)
    assert Repo.one(APIToken).id == api_token.id
    {:ok, new_api_token} = RefreshAPIToken.exec(api_token.access_token, api_token.refresh_token)
    refute new_api_token.id == api_token.id
    assert Repo.one(APIToken).id == new_api_token.id
    assert new_api_token.user_id == api_token.user_id
  end

  test "returns error when access_token doesn't exist" do
    expected = {:operation_error, "Invalid credentials!"}
    assert expected == RefreshAPIToken.exec(nil, nil)
    assert expected == RefreshAPIToken.exec("", nil)
  end

  test "returns error when refresh_token doesn't exist" do
    expected = {:operation_error, "Invalid credentials!"}
    assert expected == RefreshAPIToken.exec("1234", nil)
    assert expected == RefreshAPIToken.exec("1234", "")
  end

  test "returns error when access_token not found" do
    expected = {:operation_error, "Invalid credentials!"}
    assert expected == RefreshAPIToken.exec("1234", "5678")
  end

  test "returns error when refresh_token doesn't match" do
    api_token = insert(:api_token)
    expected = {:operation_error, "Invalid credentials!"}
    assert expected == RefreshAPIToken.exec(api_token.access_token, "5678")
  end

end