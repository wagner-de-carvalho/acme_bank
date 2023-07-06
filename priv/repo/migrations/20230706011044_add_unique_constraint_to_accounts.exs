defmodule AcmeBank.Repo.Migrations.AddUniqueConstraintToAccounts do
  use Ecto.Migration
  alias AcmeBank.Accounts.Account

  def change do
    create unique_index(:accounts, [:user_id], name: :accounts_unique_user_id)
  end
end
