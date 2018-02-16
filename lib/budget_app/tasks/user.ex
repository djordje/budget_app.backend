defmodule Mix.Tasks.User do
  
  defmodule Add do
    use Mix.Task

    alias BudgetApp.Operations.RegisterUser

    @moduledoc """
    Register new user with email, password and password confirmation
      
        `mix user.add <email> <password> <password_confirmation>`

      - email: this has to be uniq value in DB
      - password: desired user password
      - password_confirmation: confirm user password
      

      Example:

      `mix user.add user@example.com password123 password123`
    """
    
    @shortdoc "Register new user with email, password and password confirmation"
    def run([email | [password | [password_confirmation | _]]]) do
      {:ok, _started} = Application.ensure_all_started(:budget_app)
      case RegisterUser.exec(email, password, password_confirmation) do
        {:ok, user} -> Mix.shell.info("User[#{user.id}] with email `#{user.email}` sucessfully registered.")
        _           -> Mix.shell.error("Something wen wrong, user not created!")
      end
    end
  end

end