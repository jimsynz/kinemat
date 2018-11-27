defimpl Kinemat.Vector, for: Kinemat.Vector.Vector1 do
  alias Kinemat.Vector.Vector1
  alias Kinemat.MatrixNif
  alias Kinemat.MatrixNif.{IntoTuple, FromTuple}

  @moduledoc false

  @doc """
  You can't truncate a 1-dimensional vector.

  ## Example

      iex> Vector1.init(1885)
      ...> |> Vector.truncate()
      {:error, "Cannot truncate Vector1"}
  """
  @spec truncate(Vector1.t()) :: {:error, binary}
  def truncate(_vector), do: {:error, "Cannot truncate Vector1"}

  @doc """
  You can't truncate a 1-dimensional vector.

  ## Example

      iex> Vector1.init(1885)
      ...> |> Vector.truncate_n(1)
      {:error, "Cannot truncate Vector1"}
  """
  @spec truncate_n(Vector1.t(), number) :: {:error, binary}
  def truncate_n(_vector, _n), do: {:error, "Cannot truncate Vector1"}

  @doc """
  Add two `lhs` and `rhs`.

  ## Example

      iex> lhs = Vector1.init(1885)
      ...> rhs = Vector1.init(1995)
      ...> Vector.add(lhs, rhs)
      {:ok, %Vector1{x: 3880.0}}
  """
  @spec add(Vector1.t(), Vector1.t()) :: {:ok, Vector1.t()} | {:error, binary}
  def add(lhs, rhs) do
    with {:vector1, _x} = lhs <- IntoTuple.into(lhs),
         {:vector1, _y} = rhs <- IntoTuple.into(rhs),
         {:ok, vec} <- MatrixNif.vector1_add(lhs, rhs),
         {:ok, vec} <- FromTuple.from(vec),
         do: {:ok, vec}
  end
end
