defimpl Kinemat.Vector, for: Kinemat.Vector.Vector1 do
  alias Kinemat.Vector.Vector1

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
end
