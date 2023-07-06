defmodule AcmeBankWeb.AccountsJSON do
  alias AcmeBank.Accounts.Account
  alias AcmeBank.Repo

  def create(%{account: account}) do
    %{
      message: "Account created",
      data: data(account)
    }
  end

  def transaction(%{transaction: transaction}) do
    %{
      data: account_data(transaction),
      message: "Bank transfer"
    }
  end

  defp data(%Account{} = account) do
    %{user: user} = Repo.preload(account, :user)

    %{
      balance: account.balance,
      user_name: user.name,
      user_email: user.email
    }
  end

  # defp account_data(%{deposit: deposit, value: value} = transaction) do
  defp account_data(%{deposit: to_account, withdraw: from_account, value: value} = _transaction) do
    %{user: from_user} = Repo.preload(from_account, :user)
    %{user: to_user} = Repo.preload(to_account, :user)

    %{
      from: from_user.name,
      to: to_user.name,
      value: value,
      balance: to_account.balance
    }
  end
end
