defmodule BudgetApp.ExchangeRate do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetApp.ExchangeRate


  schema "exchange_rates" do
    field :monthly, :boolean, default: false
    field :on_date, :naive_datetime
    field :rate, :float

    timestamps()

    belongs_to :from_currency, BudgetApp.Currency
    belongs_to :to_currency, BudgetApp.Currency
  end

  @doc false
  def changeset(%ExchangeRate{} = exchange_rate, attrs) do
    exchange_rate
    |> cast(attrs, [:on_date, :rate, :monthly, :from_currency_id, :to_currency_id])
    |> validate_required([:on_date, :rate, :monthly])
  end
end
