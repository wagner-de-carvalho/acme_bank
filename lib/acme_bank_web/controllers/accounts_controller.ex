defmodule AcmeBankWeb.AccountsController do
  use AcmeBankWeb, :controller
  alias AcmeBank.Accounts
  alias AcmeBank.Accounts.Account
  alias AcmeBankWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end
end