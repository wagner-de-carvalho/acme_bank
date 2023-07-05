defmodule AcmeBankWeb.FallbackController do
  use AcmeBankWeb, :controller
  alias AcmeBankWeb.ErrorJSON

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :bad_request)
  end

  def call(conn, {:error, status}) when is_atom(status) do
    conn
    |> put_status(status)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: status)
  end

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
