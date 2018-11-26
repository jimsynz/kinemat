defimpl Collectable, for: Kinemat.Vector.Vector2 do
  alias Kinemat.Vector.Vector2

  @moduledoc """
  Implements `Collectable` for `Vector2`.  Only supports 2 element lists.
  """

  @doc """
  Collect an enumerable into a `Vector2`.

  ## Examples

      iex> [1955, 1985]
      ...> |> Enum.into(Vector2.zero())
      %Vector2{x: 1955, y: 1985}
  """
  @spec into(Vector2.t()) :: {list, function}
  def into(_original) do
    collector_fun = fn
      list, {:cont, value} when is_number(value) -> [value | list]
      [y, x], :done -> Vector2.init(x, y)
      _vector, :halt -> :ok
    end

    {[], collector_fun}
  end
end
