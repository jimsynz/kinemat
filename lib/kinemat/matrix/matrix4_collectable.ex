defimpl Collectable, for: Kinemat.Matrix.Matrix4 do
  alias Kinemat.Matrix.Matrix4
  alias Kinemat.Vector.Vector4

  @moduledoc """
  Implements `Collectable` for `Matrix4`.  Converts 4 element lists of numbers.
  """

  @doc """
  Collect an enumerable into a `Matrix4`.

  ## Examples

      iex> [1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix4.zero())
      %Matrix4{x: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, y: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, z: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, w: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}}
  """
  @spec into(Matrix4.t()) :: {list, function}
  def into(_original) do
    collector_fun = fn
      list, {:cont, value} when is_number(value) ->
        [value | list]

      [ww, wz, wy, wx, zw, zz, zy, zx, yw, yz, yy, yx, xw, xz, xy, xx], :done ->
        Matrix4.init(
          Vector4.init(xx, xy, xz, xw),
          Vector4.init(yx, yy, yz, yw),
          Vector4.init(zx, zy, zz, zw),
          Vector4.init(wx, wy, wz, ww)
        )

      _vector, :halt ->
        :ok
    end

    {[], collector_fun}
  end
end
