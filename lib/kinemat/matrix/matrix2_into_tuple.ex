defimpl Kinemat.MatrixNif.IntoTuple, for: Kinemat.Matrix.Matrix2 do
  alias Kinemat.Matrix.Matrix2
  alias Kinemat.Vector.Vector2

  @moduledoc false

  @doc """
  Convert a `Matrix2` into a tuple.

  ## Example

      iex> Matrix2.init(Vector2.init(1885, 1955), Vector2.init(1985, 2015))
      ...> |> IntoTuple.into()
      {:matrix2, 1885, 1955, 1985, 2015}
  """
  @spec into(Matrix2.t()) :: {:matrix2, number, number, number, number}
  def into(%Matrix2{x: %Vector2{x: xx, y: xy}, y: %Vector2{x: yx, y: yy}}),
    do: {:matrix2, xx, xy, yx, yy}
end
