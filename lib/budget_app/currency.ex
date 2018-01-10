defmodule BudgetApp.Currency do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetApp.Currency


  schema "currencies" do
    field :iso_code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Currency{} = currency, attrs) do
    currency
    |> cast(attrs, [:name, :iso_code])
    |> validate_required([:name, :iso_code])
    |> validate_length(:iso_code, is: 3)
  end
end
