defimpl Kinemat.MatrixNif.IntoTuple, for: Kinemat.Matrix.Matrix4 do
  alias Kinemat.Matrix.Matrix4
  alias Kinemat.Vector.Vector4

  @moduledoc false

  @doc """
  Convert a `Matrix4` into a tuple.

  ## Example

      iex> vec4 = Vector4.init(1885, 1955, 1985, 2015)
      ...> Matrix4.init(vec4, vec4, vec4, vec4)
      ...> |> IntoTuple.into()
      {:matrix4, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015}
  """
  @spec into(Matrix4.t()) ::
          {:matrix4, number, number, number, number, number, number, number, number, number,
           number, number, number, number, number, number, number}
  def into(%Matrix4{
        x: %Vector4{x: xx, y: xy, z: xz, w: xw},
        y: %Vector4{x: yx, y: yy, z: yz, w: yw},
        z: %Vector4{x: zx, y: zy, z: zz, w: zw},
        w: %Vector4{x: wx, y: wy, z: wz, w: ww}
      }),
      do: {:matrix4, xx, xy, xz, xw, yx, yy, yz, yw, zx, zy, zz, zw, wx, wy, wz, ww}
end
