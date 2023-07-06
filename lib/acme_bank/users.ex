defmodule AcmeBank.Users do
  alias AcmeBank.Users.Create
  alias AcmeBank.Users.Delete
  alias AcmeBank.Users.Get
  alias AcmeBank.Users.Update
  alias AcmeBank.Users.Verify

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate login(params), to: Verify, as: :call
  defdelegate update(params), to: Update, as: :call
end
