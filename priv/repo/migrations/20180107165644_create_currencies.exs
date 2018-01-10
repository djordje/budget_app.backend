defmodule BudgetApp.Repo.Migrations.CreateCurrencies do
  use Ecto.Migration

  def change do
    create table(:currencies) do
      add :name, :string, size: 50, null: false
      add :iso_code, :string, size: 3, null: false

      timestamps()
    end

  end
end
