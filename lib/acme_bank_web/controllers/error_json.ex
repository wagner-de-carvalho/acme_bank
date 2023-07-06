defmodule AcmeBankWeb.ErrorJSON do
  alias Ecto.Changeset
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def error(%{status: :bad_request}), do: %{status: :bad_request}
  def error(%{status: :not_found}), do: %{status: :not_found, message: "User not found"}
  def error(%{status: status}), do: %{status: status}
  def error(%{message: message}), do: %{message: message}

  def error(%{changeset: changeset}) do
    %{
      errors: Changeset.traverse_errors(changeset, &translate_errors/1)
    }
  end

  defp translate_errors({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts
      |> Keyword.get(String.to_existing_atom(key), key)
      |> to_string()
    end)
  end
end
