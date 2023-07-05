defmodule AcmeBank.Users.Get do
  alias AcmeBank.Users.User
  alias AcmeBank.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
