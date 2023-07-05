defmodule AcmeBankWeb.UsersController do
  use AcmeBankWeb, :controller
  alias AcmeBankWeb.FallbackController
  alias AcmeBank.Users
  alias Users.User

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  def delete(conn, %{"id" => id} = _params) do
    with {:ok, %User{} = _user} <- Users.delete(id) do
      conn
      |> put_status(:no_content)
      |> send_resp(:no_content, "")
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, user: user)
    end
  end
end
