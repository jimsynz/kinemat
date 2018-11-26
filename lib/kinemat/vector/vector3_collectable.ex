defimpl Collectable, for: Kinemat.Vector.Vector3 do
  alias Kinemat.Vector.Vector3

  @moduledoc """
  Implements `Collectable` for `Vector3`.  Only supports 2 element lists.
  """

  @doc """
  Collect an enumerable into a `Vector3`.

  ## Examples

      iex> [1955, 1985, 2015]
      ...> |> Enum.into(Vector3.zero())
      %Vector3{x: 1955, y: 1985, z: 2015}
  """
  @spec into(Vector3.t()) :: {list, function}
  def into(_original) do
    collector_fun = fn
      list, {:cont, value} when is_number(value) -> [value | list]
      [z, y, x], :done -> Vector3.init(x, y, z)
      _vector, :halt -> :ok
    end

    {[], collector_fun}
  end
end
