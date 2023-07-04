defmodule AcmeBankWeb.FallbackController do
  use AcmeBankWeb, :controller
  alias AcmeBankWeb.ErrorJSON

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end