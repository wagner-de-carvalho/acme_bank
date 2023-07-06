defmodule AcmeBankWeb.UsersJSON do
  alias AcmeBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}
  def login(%{token: token}), do: %{message: "Authenticated", bearer: token}

  def update(%{user: user}), do: %{data: data(user), message: "User updated"}

  defp data(%User{} = user), do: user
end
