defmodule AcmeBank.Users.Delete do
  alias AcmeBank.Repo
  alias AcmeBank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end
end
