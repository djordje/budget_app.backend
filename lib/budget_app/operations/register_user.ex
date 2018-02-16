defmodule BudgetApp.Operations.RegisterUser do
  alias BudgetApp.User
  alias BudgetApp.Repo

  def exec(email, _, _) when email in ["", nil], do: {:operation_error, "Email not given!"}
  def exec(_, password, _) when password in ["", nil], do: {:operation_error, "Password not given!"}
  def exec(_, password, confirmation) when password !== confirmation, do: {:operation_error, "Password not confirmed!"}

  def exec(email, password, _) do
    %User{}
    |> User.changeset(%{email: email, secret: create_secret(password)})
    |> Repo.insert
  end

  defp create_secret(password) do
    Comeonin.Argon2.hashpwsalt(password)
  end

end