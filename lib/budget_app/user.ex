defmodule BudgetApp.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetApp.User


  schema "users" do
    field :email, :string
    field :secret, :string

    timestamps()

    has_many :api_tokens, BudgetApp.APIToken
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :secret])
    |> validate_required([:email, :secret])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
