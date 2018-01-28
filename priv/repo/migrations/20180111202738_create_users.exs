defmodule BudgetApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, size: 50, unique: true
      add :secret, :string, size: 128

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
