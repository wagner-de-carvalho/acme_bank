defmodule AcmeBank.Users.Create do
  alias AcmeBank.Repo
  alias AcmeBank.Users.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
