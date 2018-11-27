defmodule Kinemat.MatrixNif.FromTuple do
  alias Kinemat.{Matrix, Vector}
  alias Kinemat.Vector.{Vector1, Vector2, Vector3, Vector4}
  alias Kinemat.Matrix.{Matrix2, Matrix3, Matrix4}

  @moduledoc false

  @doc """
  Convert from a tuple returned by our NIFs back into a Struct.

  ## Examples

      iex> {:vector1, 1.21}
      ...> |> FromTuple.from()
      {:ok, %Vector1{x: 1.21}}

      iex> {:vector2, 1885, 1955}
      ...> |> FromTuple.from()
      {:ok, %Vector2{x: 1885, y: 1955}}

      iex> {:vector3, 1885, 1955, 1985}
      ...> |> FromTuple.from()
      {:ok, %Vector3{x: 1885, y: 1955, z: 1985}}

      iex> {:vector4, 1885, 1955, 1985, 2015}
      ...> |> FromTuple.from()
      {:ok, %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}}

      iex> {:matrix2, {:vector2, 1885, 1955}, {:vector2, 1985, 2015}}
      ...> |> FromTuple.from()
      {:ok, %Matrix2{x: %Vector2{x: 1885, y: 1955}, y: %Vector2{x: 1985, y: 2015}}}

      iex> {:matrix3, {:vector3, 1885, 1955, 1985}, {:vector3, 2015, 1885, 1955}, {:vector3, 1985, 2015, 1885}}
      ...> |> FromTuple.from()
      {:ok, %Matrix3{x: %Vector3{x: 1885, y: 1955, z: 1985}, y: %Vector3{x: 2015, y: 1885, z: 1955}, z: %Vector3{x: 1985, y: 2015, z: 1885}}}

      iex> {:matrix4, {:vector4, 1885, 1955, 1985, 2015}, {:vector4, 1885, 1955, 1985, 2015}, {:vector4, 1885, 1955, 1985, 2015}, {:vector4, 1885, 1955, 1985, 2015}}
      ...> |> FromTuple.from()
      {:ok, %Matrix4{x: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, y: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, z: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, w: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}}}

  """
  @spec from(tuple) :: Vector.t() | Matrix.t()
  def from({:vector1, x}), do: {:ok, Vector1.init(x)}
  def from({:vector2, x, y}), do: {:ok, Vector2.init(x, y)}
  def from({:vector3, x, y, z}), do: {:ok, Vector3.init(x, y, z)}
  def from({:vector4, x, y, z, w}), do: {:ok, Vector4.init(x, y, z, w)}

  def from({:matrix2, {:vector2, xx, xy}, {:vector2, yx, yy}}),
    do: {:ok, Matrix2.init(Vector2.init(xx, xy), Vector2.init(yx, yy))}

  def from({:matrix3, {:vector3, xx, xy, xz}, {:vector3, yx, yy, yz}, {:vector3, zx, zy, zz}}),
    do:
      {:ok,
       Matrix3.init(
         Vector3.init(xx, xy, xz),
         Vector3.init(yx, yy, yz),
         Vector3.init(zx, zy, zz)
       )}

  def from(
        {:matrix4, {:vector4, xx, xy, xz, xw}, {:vector4, yx, yy, yz, yw},
         {:vector4, zx, zy, zz, zw}, {:vector4, wx, wy, wz, ww}}
      ),
      do:
        {:ok,
         Matrix4.init(
           Vector4.init(xx, xy, xz, xw),
           Vector4.init(yx, yy, yz, yw),
           Vector4.init(zx, zy, zz, zw),
           Vector4.init(wx, wy, wz, ww)
         )}
end
