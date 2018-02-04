defmodule BudgetApp.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :amount, :float
      add :on_date, :naive_datetime
      add :desc, :text
      add :currency_id, references(:currencies, on_delete: :nothing)

      timestamps()
    end

    create index(:expenses, [:currency_id])
  end
end
