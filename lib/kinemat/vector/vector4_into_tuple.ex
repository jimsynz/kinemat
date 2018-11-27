defimpl Kinemat.MatrixNif.IntoTuple, for: Kinemat.Vector.Vector4 do
  alias Kinemat.Vector.Vector4

  @moduledoc false

  @doc """
  Convert a `Vector4` into a tuple.

  ## Example

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> IntoTuple.into()
      {:vector4, 1885, 1955, 1985, 2015}
  """
  @spec into(Vector4.t()) :: {:vector4, number, number, number, number}
  def into(%Vector4{x: x, y: y, z: z, w: w}), do: {:vector4, x, y, z, w}
end
