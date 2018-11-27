defimpl Kinemat.MatrixNif.IntoTuple, for: Kinemat.Matrix.Matrix3 do
  alias Kinemat.Matrix.Matrix3
  alias Kinemat.Vector.Vector3

  @moduledoc false

  @doc """
  Convert a `Matrix3` into a tuple.

  ## Example

      iex> Matrix3.init(Vector3.init(1885, 1955, 1985), Vector3.init(2015, 1885, 1955), Vector3.init(1985, 2015, 1955))
      ...> |> IntoTuple.into()
      {:matrix3, {:vector3, 1885, 1955, 1985}, {:vector3, 2015, 1885, 1955}, {:vector3, 1985, 2015, 1955}}
  """
  @spec into(Matrix3.t()) ::
          {:matrix3, {:vector3, number, number, number}, {:vector3, number, number, number},
           {:vector3, number, number, number}}
  def into(%Matrix3{
        x: %Vector3{x: xx, y: xy, z: xz},
        y: %Vector3{x: yx, y: yy, z: yz},
        z: %Vector3{x: zx, y: zy, z: zz}
      }),
      do: {:matrix3, {:vector3, xx, xy, xz}, {:vector3, yx, yy, yz}, {:vector3, zx, zy, zz}}
end
