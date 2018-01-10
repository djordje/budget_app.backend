defmodule BudgetApp.Repo.Migrations.CreateExchangeRates do
  use Ecto.Migration

  def change do
    create table(:exchange_rates) do
      add :on_date, :naive_datetime
      add :rate, :float
      add :monthly, :boolean, default: false, null: false
      add :from_currency_id, references(:currencies, on_delete: :nothing)
      add :to_currency_id, references(:currencies, on_delete: :nothing)

      timestamps()
    end

    create index(:exchange_rates, [:from_currency_id])
    create index(:exchange_rates, [:to_currency_id])
  end
end
