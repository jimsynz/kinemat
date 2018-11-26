defimpl Collectable, for: Kinemat.Matrix.Matrix2 do
  alias Kinemat.Matrix.Matrix2
  alias Kinemat.Vector.Vector2

  @moduledoc """
  Implements `Collectable` for `Matrix2`.  Converts 4 element lists of numbers.
  """

  @doc """
  Collect an enumerable into a `Matrix2`.

  ## Examples

      iex> [1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix2.zero())
      %Matrix2{x: %Vector2{x: 1885, y: 1955}, y: %Vector2{x: 1985, y: 2015}}
  """
  @spec into(Matrix2.t()) :: {list, function}
  def into(_original) do
    collector_fun = fn
      list, {:cont, value} when is_number(value) -> [value | list]
      [yy, yx, xy, xx], :done -> Matrix2.init(Vector2.init(xx, xy), Vector2.init(yx, yy))
      _vector, :halt -> :ok
    end

    {[], collector_fun}
  end
end
