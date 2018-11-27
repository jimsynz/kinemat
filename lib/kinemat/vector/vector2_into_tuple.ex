defimpl Kinemat.MatrixNif.IntoTuple, for: Kinemat.Vector.Vector2 do
  alias Kinemat.Vector.Vector2

  @moduledoc false

  @doc """
  Convert a `Vector2` into a tuple.

  ## Example

      iex> Vector2.init(1885, 1955)
      ...> |> IntoTuple.into()
      {:vector2, 1885, 1955}
  """
  @spec into(Vector2.t()) :: {:vector2, number, number}
  def into(%Vector2{x: x, y: y}), do: {:vector2, x, y}
end
