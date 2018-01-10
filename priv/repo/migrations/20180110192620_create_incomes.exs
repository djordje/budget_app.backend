defmodule BudgetApp.Repo.Migrations.CreateIncomes do
  use Ecto.Migration

  def change do
    create table(:incomes) do
      add :amount, :float
      add :on_date, :naive_datetime
      add :for_date, :naive_datetime
      add :desc, :text
      add :currency_id, references(:currencies, on_delete: :nothing)

      timestamps()
    end

    create index(:incomes, [:currency_id])
  end
end
