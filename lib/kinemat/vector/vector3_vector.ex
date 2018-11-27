defimpl Kinemat.Vector, for: Kinemat.Vector.Vector3 do
  alias Kinemat.Vector.{Vector2, Vector3}
  @moduledoc false

  @doc """
  Truncate a `Vector3` into a `Vector2` by dropping the last element.

  ## Example

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Vector.truncate()
      {:ok, %Vector2{x: 1885, y: 1955}}
  """
  @spec truncate(Vector3.t()) :: {:ok, Vector2.t()}
  def truncate(%Vector3{x: x, y: y}), do: {:ok, Vector2.init(x, y)}

  @doc """
  Truncate a `Vector3` into a `Vector2` by dropping the `n`th element.

  ## Examples

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Vector.truncate_n(0)
      {:ok, %Vector2{x: 1955, y: 1985}}

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Vector.truncate_n(1)
      {:ok, %Vector2{x: 1885, y: 1985}}

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Vector.truncate_n(2)
      {:ok, %Vector2{x: 1885, y: 1955}}

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Vector.truncate_n(3)
      {:error, "Out of range"}
  """
  @spec truncate_n(Vector3.t(), non_neg_integer) :: {:ok, Vector2.t()} | {:error, binary}
  def truncate_n(%Vector3{y: y, z: z}, 0), do: {:ok, Vector2.init(y, z)}
  def truncate_n(%Vector3{x: x, z: z}, 1), do: {:ok, Vector2.init(x, z)}
  def truncate_n(%Vector3{x: x, y: y}, 2), do: {:ok, Vector2.init(x, y)}
  def truncate_n(_vector, _n), do: {:error, "Out of range"}
end
