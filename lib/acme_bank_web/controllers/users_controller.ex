defmodule AcmeBankWeb.UsersController do
  use AcmeBankWeb, :controller
  alias AcmeBankWeb.ErrorJSON
  alias AcmeBank.Users.{Create, User}

  def create(conn, params) do
    params
    |> Create.call()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %User{} = user}, conn) do
    conn
    |> put_status(:created)
    |> render(:create, user: user)
  end

  defp handle_response({:error, changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
