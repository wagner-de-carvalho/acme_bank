defmodule AcmeBankWeb.AccountsJSON do
  alias AcmeBank.Accounts.Account
  alias AcmeBank.Repo

  def create(%{account: account}) do
    %{
      message: "Account created",
      data: data(account)
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
end
