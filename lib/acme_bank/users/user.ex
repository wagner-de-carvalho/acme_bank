defmodule AcmeBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias AcmeBank.Accounts.Account
  alias Ecto.Changeset

  @fields [:name, :password, :email, :cep]
  @required @fields

  @derive {Jason.Encoder, only: @fields -- [:password]}

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string
    has_one :account, Account

    timestamps()
  end

  def changeset(params) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(user, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
    |> add_password_hash()
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(%Changeset{valid?: false} = changeset), do: changeset
end
