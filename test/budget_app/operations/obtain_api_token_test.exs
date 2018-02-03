defmodule BudgetApp.Operations.ObtainAPITokenTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.ObtainAPIToken
  alias BudgetApp.APIToken
  alias BudgetApp.User
  alias BudgetApp.Repo

  def fixture do
    email = "test@example.com"
    secret = Comeonin.Argon2.hashpwsalt("1234")
    %User{}
    |> User.changeset(%{email: email, secret: secret})
    |> Repo.insert
  end

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
    fixture()
    expected = {:error, "Invalid credentials!"}
    assert expected == ObtainAPIToken.exec("test@example.com", "123")
  end

  test "saves record to the DB" do
    fixture()
    assert Repo.aggregate(APIToken, :count, :id) == 0
    ObtainAPIToken.exec("test@example.com", "1234")
    assert Repo.aggregate(APIToken, :count, :id) == 1
  end

end