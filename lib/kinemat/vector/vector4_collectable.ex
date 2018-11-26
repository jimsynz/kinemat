defimpl Collectable, for: Kinemat.Vector.Vector4 do
  alias Kinemat.Vector.Vector4

  @moduledoc """
  Implements `Collectable` for `Vector4`.  Only supports 2 element lists.
  """

  @doc """
  Collect an enumerable into a `Vector4`.

  ## Examples

      iex> [1885, 1955, 1985, 2015]
      ...> |> Enum.into(Vector4.zero())
      %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}
  """
  @spec into(Vector4.t()) :: {list, function}
  def into(_original) do
    collector_fun = fn
      list, {:cont, value} when is_number(value) -> [value | list]
      [w, z, y, x], :done -> Vector4.init(x, y, z, w)
      _vector, :halt -> :ok
    end

    {[], collector_fun}
  end
end
