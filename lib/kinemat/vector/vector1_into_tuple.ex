defimpl Kinemat.MatrixNif.IntoTuple, for: Kinemat.Vector.Vector1 do
  alias Kinemat.Vector.Vector1

  @moduledoc false

  @doc """
  Convert a `Vector1` into a tuple.

  ## Example

      iex> Vector1.init(1.21)
      ...> |> IntoTuple.into()
      {:vector1, 1.21}
  """
  @spec into(Vector1.t()) :: {:vector1, number}
  def into(%Vector1{x: x}) when is_integer(x), do: {:vector1, x * 1.0}
  def into(%Vector1{x: x}) when is_float(x), do: {:vector1, x}
end
