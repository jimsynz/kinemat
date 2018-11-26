defimpl Collectable, for: Kinemat.Vector.Vector1 do
  alias Kinemat.Vector.Vector1

  @moduledoc """
  Implements `Collectable` for `Vector1`.  Only supports 1 element lists.
  """

  @doc """
  Collect an enumerable into a `Vector1`.

  ## Examples

      iex> [1.21]
      ...> |> Enum.into(Vector1.zero())
      %Vector1{x: 1.21}
  """
  @spec into(Vector1.t()) :: {list, function}
  def into(_original) do
    collector_fun = fn
      list, {:cont, value} when is_number(value) -> [value | list]
      [x], :done -> Vector1.init(x)
      _vector, :halt -> :ok
    end

    {[], collector_fun}
  end
end
