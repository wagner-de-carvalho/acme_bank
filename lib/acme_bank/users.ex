defmodule AcmeBank.Users do
  alias AcmeBank.Users.Create

  defdelegate create(params), to: Create, as: :call
end
