defmodule AcmeBank.Accounts do
  alias AcmeBank.Accounts.Create
  alias AcmeBank.Accounts.Transaction

  defdelegate create(params), to: Create, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
