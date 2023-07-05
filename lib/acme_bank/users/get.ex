defmodule AcmeBank.Users.Get do
  alias AcmeBank.Repo
  alias AcmeBank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
