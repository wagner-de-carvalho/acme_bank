defmodule AcmeBank.Users.Create do
  alias AcmeBank.Repo
  alias AcmeBank.Users.User
  alias AcmeBank.ViaCep.Client, as: ViaCepClient

  def call(%{"cep" => cep} = params) do
    with {:ok, _body} <- client().call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client do
    Application.get_env(:acme_bank, :via_cep_client, ViaCepClient)
  end
end
