defmodule AcmeBankWeb.Token do
  alias AcmeBankWeb.Endpoint
  alias Phoenix.Token

  @sign_salt "Acme_Bank_Api_&%$@63&#"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
