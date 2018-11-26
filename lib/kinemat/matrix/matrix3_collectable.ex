defimpl Collectable, for: Kinemat.Matrix.Matrix3 do
  alias Kinemat.Matrix.Matrix3
  alias Kinemat.Vector.Vector3

  @moduledoc """
  Implements `Collectable` for `Matrix3`.  Converts 4 element lists of numbers.
  """

  @doc """
  Collect an enumerable into a `Matrix3`.

  ## Examples

      iex> [1885, 1955, 1985, 1885, 1955, 1985, 1885, 1955, 1985]
      ...> |> Enum.into(Matrix3.zero())
      %Matrix3{x: %Vector3{x: 1885, y: 1955, z: 1985}, y: %Vector3{x: 1885, y: 1955, z: 1985}, z: %Vector3{x: 1885, y: 1955, z: 1985}}
  """
  @spec into(Matrix3.t()) :: {list, function}
  def into(_original) do
    collector_fun = fn
      list, {:cont, value} when is_number(value) ->
        [value | list]

      [zz, zy, zx, yz, yy, yx, xz, xy, xx], :done ->
        Matrix3.init(Vector3.init(xx, xy, xz), Vector3.init(yx, yy, yz), Vector3.init(zx, zy, zz))

      _vector, :halt ->
        :ok
    end

    {[], collector_fun}
  end
end
