defmodule AcmeBank.Users.Delete do
  alias AcmeBank.Users.User
  alias AcmeBank.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end
end
