defmodule AcmeBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias AcmeBank.Users.User

  @required [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User
    timestamps()
  end

  def changeset(account \\ %__MODULE__{}, params) do
    account
    |> cast(params, @required)
    |> validate_required(@required)
    |> check_constraint(:balance, name: :balance_must_be_positive)
    |> unique_constraint(:user_id, name: :accounts_unique_user_id)
  end
end
