defmodule AcmeBank.ViaCep.Client do
  use Tesla
  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON
  alias Tesla.Env

  def call(cep) do
    "/#{cep}/json"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Env{status: 200, body: %{"erro" => true}}}), do: {:error, :not_found}
  defp handle_response({:ok, %Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_response({:ok, %Env{status: 400}}), do: {:error, :bad_request}
  defp handle_response({:error, _}), do: {:error, :internal_server_error}
end
