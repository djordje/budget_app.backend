defmodule BudgetApp.Expense do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetApp.Expense


  schema "expenses" do
    field :amount, :float
    field :desc, :string
    field :on_date, :naive_datetime

    timestamps()

    belongs_to :currency, BudgetApp.Currency
  end

  @doc false
  def changeset(%Expense{} = expense, attrs) do
    expense
    |> cast(attrs, [:amount, :on_date, :desc, :currency_id])
    |> validate_required([:amount, :on_date, :desc])
  end
end
