defmodule BudgetApp.Operations.ObtainAPITokenTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.ObtainAPIToken
  alias BudgetApp.APIToken
  alias BudgetApp.Repo

  test "returns error when email doesn't exist" do
    expected = {:error, "Invalid credentials!"}
    assert expected == ObtainAPIToken.exec(nil, nil)
    assert expected == ObtainAPIToken.exec("", nil)
  end

  test "returns error when password doesn't exist" do
    email = "test@example.com"
    expected = {:error, "Invalid credentials!"}
    assert expected == ObtainAPIToken.exec(email, nil)
    assert expected == ObtainAPIToken.exec(email, "")
  end

  test "returns error when user with given email not found" do
    expected = {:error, "Invalid credentials!"}
    assert expected == ObtainAPIToken.exec("test@example.com", "123")
  end

  test "returns error when password doesn't match with user's secret" do
    user = insert(:user)
    expected = {:error, "Invalid credentials!"}
    assert expected == ObtainAPIToken.exec(user.email, "123")
  end

  test "saves record to the DB" do
    user = insert(:user)
    ObtainAPIToken.exec(user.email, "1234")
    assert Repo.one(APIToken).user_id == user.id
  end

end