defmodule AcmeBankWeb.Plugs.Auth do
  import Plug.Conn
  alias AcmeBankWeb.ErrorJSON
  alias AcmeBankWeb.Token
  alias Phoenix.Controller
  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      assign(conn, :user_id, data.user_id)
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Controller.put_view(json: ErrorJSON)
        |> Controller.render(:error, status: :unauthorized)
        |> halt()
    end
  end
end
