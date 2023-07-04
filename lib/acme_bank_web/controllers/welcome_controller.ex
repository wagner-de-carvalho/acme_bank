defmodule AcmeBankWeb.WelcomeController do
  use AcmeBankWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{teste: "Bem-vindo ao Acme Bank"})
  end
end
