defmodule AcmeBank.Users do
  alias AcmeBank.Users.Create
  alias AcmeBank.Users.Get
  alias AcmeBank.Users.Update

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
end
