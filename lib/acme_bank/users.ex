defmodule AcmeBank.Users do
  alias AcmeBank.Users.Create
  alias AcmeBank.Users.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
