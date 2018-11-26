defimpl Enumerable, for: Kinemat.Vector.Vector2 do
  alias Kinemat.Vector.Vector2

  @moduledoc """
  Implements `Enumerable` for `Vector2`.
  """

  @doc """
  Returns the number of elements in a `Vector2`.

  ## Example

      iex> Vector2.init(1885, 1955)
      ...> |> Enum.count()
      2
  """
  @spec count(Vector2.t()) :: {:ok, 2}
  def count(%Vector2{}), do: {:ok, 2}

  @doc """
  Returns whether `element` is present in the `Vector2`.

  ## Examples

      iex> Vector2.init(1885, 1955)
      ...> |> Enum.member?(1885)
      true

      iex> Vector2.init(1885, 1955)
      ...> |> Enum.member?(2015)
      false
  """
  @spec member?(Vector2.t(), any) :: {:ok, boolean}
  def member?(%Vector2{x: x}, x), do: {:ok, true}
  def member?(%Vector2{y: y}, y), do: {:ok, true}
  def member?(_vector, _element), do: {:ok, false}

  @doc """
  Implements `reduce` for `Vector2` allowing it to be iterated.

  ## Example

      iex> Vector2.init(1885, 1955)
      ...> |> Enum.map(&Integer.to_string(&1, 16))
      ["75D", "7A3"]
  """
  @spec reduce(Vector2.t(), Enumerable.acc(), Enumerable.reducer()) :: Enumerable.result()
  def reduce(_vector, {:halt, acc}, _fun), do: {:halted, acc}
  def reduce(vector, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(vector, &1, fun)}
  def reduce(%Vector2{x: nil, y: nil}, {:cont, acc}, _fun), do: {:done, acc}

  def reduce(%Vector2{x: x} = vector, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Vector2{vector | x: nil}, fun.(x, acc), fun)

  def reduce(%Vector2{y: y} = vector, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Vector2{vector | y: nil}, fun.(y, acc), fun)

  @doc """
  Declines to implement `Enumerable.slice/1`.
  """
  @spec slice(Vector2.t()) :: {:error, atom}
  def slice(_vector), do: {:error, __MODULE__}
end
