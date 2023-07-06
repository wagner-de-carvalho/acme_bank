defmodule AcmeBank.Accounts.Create do
  alias AcmeBank.Accounts.Account
  alias AcmeBank.Repo

  def call(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
