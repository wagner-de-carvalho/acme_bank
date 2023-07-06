defmodule AcmeBank.Accounts do
  alias AcmeBank.Accounts.Create

  defdelegate create(params), to: Create, as: :call
end
