defmodule BudgetApp.ExchangeRate do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetApp.ExchangeRate


  schema "exchange_rates" do
    field :monthly, :boolean, default: false
    field :on_date, :naive_datetime
    field :rate, :float
    field :from_currency_id, :id
    field :to_currency_id, :id

    timestamps()
  end

  @doc false
  def changeset(%ExchangeRate{} = exchange_rate, attrs) do
    exchange_rate
    |> cast(attrs, [:on_date, :rate, :monthly])
    |> validate_required([:on_date, :rate, :monthly])
  end
end
