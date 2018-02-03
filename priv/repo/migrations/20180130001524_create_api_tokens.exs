defmodule BudgetApp.Repo.Migrations.CreateApiTokens do
  use Ecto.Migration

  def change do
    create table(:api_tokens) do
      add :access_token, :string
      add :refresh_token, :string
      add :expires_at, :naive_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:api_tokens, [:access_token])
    create unique_index(:api_tokens, [:refresh_token])
    create index(:api_tokens, [:user_id])
  end
end
