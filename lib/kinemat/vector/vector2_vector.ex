defimpl Kinemat.Vector, for: Kinemat.Vector.Vector2 do
  alias Kinemat.Vector.{Vector1, Vector2}
  @moduledoc false

  @doc """
  Truncate a `Vector2` into a `Vector1` by dropping the last element.

  ## Example

      iex> Vector2.init(1885, 1955)
      ...> |> Vector.truncate()
      {:ok, %Vector1{x: 1885}}
  """
  @spec truncate(Vector2.t()) :: {:ok, Vector1.t()}
  def truncate(%Vector2{x: x}), do: {:ok, Vector1.init(x)}

  @doc """
  Truncate a `Vector2` into a `Vector1` by dropping the `n`th element.

  ## Examples

      iex> Vector2.init(1885, 1955)
      ...> |> Vector.truncate_n(0)
      {:ok, %Vector1{x: 1885}}

      iex> Vector2.init(1885, 1955)
      ...> |> Vector.truncate_n(1)
      {:ok, %Vector1{x: 1955}}

      iex> Vector2.init(1885, 1955)
      ...> |> Vector.truncate_n(2)
      {:error, "Out of range"}
  """
  @spec truncate_n(Vector2.t(), non_neg_integer) :: {:ok, Vector1.t()} | {:error, binary}
  def truncate_n(%Vector2{x: x}, 0), do: {:ok, Vector1.init(x)}
  def truncate_n(%Vector2{y: y}, 1), do: {:ok, Vector1.init(y)}
  def truncate_n(_vecotr, _n), do: {:error, "Out of range"}
end
