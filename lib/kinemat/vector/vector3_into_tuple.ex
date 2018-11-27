defimpl Kinemat.MatrixNif.IntoTuple, for: Kinemat.Vector.Vector3 do
  alias Kinemat.Vector.Vector3

  @moduledoc false

  @doc """
  Convert a `Vector3` into a tuple.

  ## Example

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> IntoTuple.into()
      {:vector3, 1885, 1955, 1985}
  """
  @spec into(Vector3.t()) :: {:vector3, number, number, number}
  def into(%Vector3{x: x, y: y, z: z}), do: {:vector3, x, y, z}
end
