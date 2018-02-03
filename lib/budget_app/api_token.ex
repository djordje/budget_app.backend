defmodule BudgetApp.APIToken do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetApp.APIToken


  schema "api_tokens" do
    field :access_token, :string
    field :expires_at, :naive_datetime
    field :refresh_token, :string

    timestamps()

    belongs_to :user, BudgetApp.User
  end

  @doc false
  def changeset(%APIToken{} = api_token, attrs) do
    api_token
    |> cast(attrs, [:access_token, :refresh_token, :expires_at])
    |> validate_required([:access_token, :refresh_token, :expires_at])
    |> unique_constraint(:access_token)
    |> unique_constraint(:refresh_token)
  end
end
