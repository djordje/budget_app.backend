defmodule BudgetApp.Expense do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetApp.Expense


  schema "expenses" do
    field :amout, :float
    field :desc, :string
    field :on_date, :naive_datetime

    timestamps()

    belongs_to :currency, BudgetApp.Currency
  end

  @doc false
  def changeset(%Expense{} = expense, attrs) do
    expense
    |> cast(attrs, [:amout, :on_date, :desc])
    |> validate_required([:amout, :on_date, :desc])
  end
end
