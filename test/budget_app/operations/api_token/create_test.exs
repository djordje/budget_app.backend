defmodule BudgetApp.Operations.APIToken.CreateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.APIToken.Create
  alias BudgetApp.APIToken
  alias BudgetApp.Repo

  test "saves record to the DB" do
    user = insert(:user)
    assert Repo.aggregate(APIToken, :count, :id) == 0
    assert {:ok, %APIToken{}} = Create.exec(user.id)
    assert Repo.aggregate(APIToken, :count, :id) == 1
  end
end