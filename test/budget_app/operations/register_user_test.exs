defmodule BudgetApp.Operations.RegisterUserTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.RegisterUser
  alias BudgetApp.User
  alias BudgetApp.Repo

  test "returns error when email doesn't exist" do
    expected = {:operation_error, "Email not given!"}
    assert expected == RegisterUser.exec(nil, nil, nil)
    assert expected == RegisterUser.exec("", nil, nil)
  end

  test "returns error when password doesn't exist" do
    email = "test@example.com"
    expected = {:operation_error, "Password not given!"}
    assert expected == RegisterUser.exec(email, nil, nil)
    assert expected == RegisterUser.exec(email, "", nil)
  end

  test "returns error when password confirmation doesn't match password" do
    expected = {:operation_error, "Password not confirmed!"}
    assert expected == RegisterUser.exec("test@example.com", "1234", "4321")
  end

  test "saves record to the DB" do
    assert Repo.aggregate(User, :count, :id) == 0
    RegisterUser.exec("test@example.com", "1234", "1234")
    assert Repo.aggregate(User, :count, :id) == 1
  end

end