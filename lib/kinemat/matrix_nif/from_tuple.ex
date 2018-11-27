defmodule Kinemat.MatrixNif.FromTuple do
  alias Kinemat.{Matrix, Vector}

  @doc """
  Convert from a tuple returned by our NIFs back into a Struct.

  ## Examples

      iex> {:vector1, 1.21}
      ...> |> FromTuple.from()
      %Vector.Vector1{x: 1.21}

      iex> {:vector2, 1885, 1955}
      ...> |> FromTuple.from()
      %Vector.Vector2{x: 1885, y: 1955}

      iex> {:vector3, 1885, 1955, 1985}
      ...> |> FromTuple.from()
      %Vector.Vector3{x: 1885, y: 1955, z: 1985}

      iex> {:vector4, 1885, 1955, 1985, 2015}
      ...> |> FromTuple.from()
      %Vector.Vector4{x: 1885, y: 1955, z: 1985, w: 2015}

      iex> {:matrix2, 1885, 1955, 1985, 2015}
      ...> |> FromTuple.from()
      %Matrix.Matrix2{x: %Vector.Vector2{x: 1885, y: 1955}, y: %Vector.Vector2{x: 1985, y: 2015}}

      iex> {:matrix3, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885}
      ...> |> FromTuple.from()
      %Matrix.Matrix3{x: %Vector.Vector3{x: 1885, y: 1955, z: 1985}, y: %Vector.Vector3{x: 2015, y: 1885, z: 1955}, z: %Vector.Vector3{x: 1985, y: 2015, z: 1885}}

      iex> {:matrix4, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015}
      ...> |> FromTuple.from()
      %Matrix.Matrix4{x: %Vector.Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, y: %Vector.Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, z: %Vector.Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, w: %Vector.Vector4{x: 1885, y: 1955, z: 1985, w: 2015}}

  """
  @spec from(tuple) :: Vector.t() | Matrix.t()
  def from({:vector1, x}), do: Vector.Vector1.init(x)
  def from({:vector2, x, y}), do: Vector.Vector2.init(x, y)
  def from({:vector3, x, y, z}), do: Vector.Vector3.init(x, y, z)
  def from({:vector4, x, y, z, w}), do: Vector.Vector4.init(x, y, z, w)

  def from({:matrix2, xx, xy, yx, yy}),
    do: Matrix.Matrix2.init(Vector.Vector2.init(xx, xy), Vector.Vector2.init(yx, yy))

  def from({:matrix3, xx, xy, xz, yx, yy, yz, zx, zy, zz}),
    do:
      Matrix.Matrix3.init(
        Vector.Vector3.init(xx, xy, xz),
        Vector.Vector3.init(yx, yy, yz),
        Vector.Vector3.init(zx, zy, zz)
      )

  def from({:matrix4, xx, xy, xz, xw, yx, yy, yz, yw, zx, zy, zz, zw, wx, wy, wz, ww}),
    do:
      Matrix.Matrix4.init(
        Vector.Vector4.init(xx, xy, xz, xw),
        Vector.Vector4.init(yx, yy, yz, yw),
        Vector.Vector4.init(zx, zy, zz, zw),
        Vector.Vector4.init(wx, wy, wz, ww)
      )
end
