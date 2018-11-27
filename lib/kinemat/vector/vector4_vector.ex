defimpl Kinemat.Vector, for: Kinemat.Vector.Vector4 do
  alias Kinemat.Vector.{Vector3, Vector4}
  @moduledoc false

  @doc """
  Truncate a `Vector4` into a `Vector3` by dropping the last element.

  ## Example

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Vector.truncate()
      {:ok, %Vector3{x: 1885, y: 1955, z: 1985}}
  """
  @spec truncate(Vector4.t()) :: {:ok, Vector3.t()}
  def truncate(%Vector4{x: x, y: y, z: z}), do: {:ok, Vector3.init(x, y, z)}

  @doc """
  Truncate a `Vector4` into a `Vector3` by dropping the `n`th element.

  ## Examples

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Vector.truncate_n(0)
      {:ok, %Vector3{x: 1955, y: 1985, z: 2015}}

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Vector.truncate_n(1)
      {:ok, %Vector3{x: 1885, y: 1985, z: 2015}}

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Vector.truncate_n(2)
      {:ok, %Vector3{x: 1885, y: 1955, z: 2015}}

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Vector.truncate_n(3)
      {:ok, %Vector3{x: 1885, y: 1955, z: 1985}}

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Vector.truncate_n(4)
      {:error, "Out of range"}
  """
  @spec truncate_n(Vector4.t(), non_neg_integer) :: {:ok, Vector3.t()} | {:error, binary}
  def truncate_n(%Vector4{y: y, z: z, w: w}, 0), do: {:ok, Vector3.init(y, z, w)}
  def truncate_n(%Vector4{x: x, z: z, w: w}, 1), do: {:ok, Vector3.init(x, z, w)}
  def truncate_n(%Vector4{x: x, y: y, w: w}, 2), do: {:ok, Vector3.init(x, y, w)}
  def truncate_n(%Vector4{x: x, y: y, z: z}, 3), do: {:ok, Vector3.init(x, y, z)}
  def truncate_n(_vector, _n), do: {:error, "Out of range"}
end
