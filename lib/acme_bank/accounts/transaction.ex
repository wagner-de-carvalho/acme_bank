defmodule AcmeBank.Accounts.Transaction do
  alias AcmeBank.Accounts.Account
  alias AcmeBank.Repo
  alias Ecto.Multi

  def call(%{"from_account_id" => from_account_id, "to_account_id" => to_account_id, "value" => value}) do
    with :ok <- same_account(from_account_id, to_account_id),
         %Account{} = from_account <- Repo.get(Account, from_account_id),
         %Account{} = to_account <- Repo.get(Account, to_account_id),
         {:ok, value} <- Decimal.cast(value) do
      Multi.new()
      |> withdraw(from_account, value)
      |> deposit(to_account, value)
      |> Repo.transaction()
      |> handle_transaction()
    else
      {:error, :same_account} = error -> error
      nil -> {:error, :not_found}
      :error -> {:error, "Invalid amount"}
      false -> {:error, "insufficient funds"}
    end
  end

  def call(_), do: {:error, "Invalid params"}

  defp same_account(account_id1, account_id2) do
    case account_id1 == account_id2 do
      true -> {:error, :same_account}
      false -> :ok
    end
  end

  defp deposit(multi, to_account, value) do
    to_account.balance
    |> Decimal.add(value)
    |> then(&Account.changeset(to_account, %{balance: &1}))
    |> then(&Multi.update(multi, :deposit, &1))
  end

  defp withdraw(multi, from_account, value) do
    from_account.balance
    |> Decimal.sub(value)
    |> then(&Account.changeset(from_account, %{balance: &1}))
    |> then(&Multi.update(multi, :withdraw, &1))
  end

  defp handle_transaction({:ok, _} = result), do: result
  defp handle_transaction({:error, _op, reason, _body}), do: {:error, reason}
end
