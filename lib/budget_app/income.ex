defmodule BudgetApp.Income do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetApp.Income


  schema "incomes" do
    field :amount, :float
    field :desc, :string
    field :for_date, :naive_datetime
    field :on_date, :naive_datetime
    field :currency_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Income{} = income, attrs) do
    income
    |> cast(attrs, [:amount, :on_date, :for_date, :desc])
    |> validate_required([:amount, :on_date, :for_date, :desc])
  end
end
