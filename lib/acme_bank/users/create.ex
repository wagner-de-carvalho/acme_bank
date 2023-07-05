defmodule AcmeBank.Users.Create do
  alias AcmeBank.Repo
  alias AcmeBank.Users.User
  alias AcmeBank.ViaCep.Client, as: ViaCepClient

  def call(%{"cep" => cep} = params) do
    with {:ok, _body} <- ViaCepClient.call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end
end
