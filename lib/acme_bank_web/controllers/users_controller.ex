defmodule AcmeBankWeb.UsersController do
  use AcmeBankWeb, :controller
  alias AcmeBankWeb.FallbackController
  alias AcmeBank.{Users, Users.User}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
end
