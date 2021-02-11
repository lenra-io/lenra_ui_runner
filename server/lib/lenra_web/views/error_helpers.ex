defmodule LenraWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @errors [
    password_not_equals: %{code: 1, message: "Password must be equals."},
    parameters_null: %{code: 2, message: "Parameters can't be null."},
    no_validation_code: %{
      code: 3,
      message: "There is no validation code for this user."
    },
    email_or_password_incorrect: %{code: 4, message: "Incorrect email or password"},
    no_such_registration_code: %{code: 5, message: "No such registration code"},
    unhandled_resource_type: %{code: 7, message: "Unknown resource."},
    openfaas_not_reachable: %{code: 1000, message: "Openfaas is not accessible"}
  ]

  def translate_errors([]), do: []
  def translate_errors([err | errs]), do: translate_error(err) ++ translate_errors(errs)

  def translate_error(%Ecto.Changeset{errors: errors}) do
    Enum.map(errors, &translate_ecto_error/1)
  end

  def translate_error(err) when is_atom(err) do
    [Keyword.get(@errors, err, %{code: 0, message: "Unknown error"})]
  end

  def translate_ecto_error({field, {msg, opts}}) do
    message =
      Enum.reduce(opts, "#{field} : #{msg}", fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)

    %{code: 0, message: message}
  end
end
