defimpl Enumerable, for: Kinemat.Vector.Vector1 do
  alias Kinemat.Vector.Vector1

  @moduledoc """
  Implements `Enumerable` for `Vector1`.
  """

  @doc """
  Returns the number of elements in a `Vector1`.

  ## Example

      iex> Vector1.init(1885)
      ...> |> Enum.count()
      1
  """
  @spec count(Vector1.t()) :: {:ok, 1}
  def count(%Vector1{}), do: {:ok, 1}

  @doc """
  Returns whether `element` is present in the `Vector1`.

  ## Examples

      iex> Vector1.init(1885)
      ...> |> Enum.member?(1885)
      true

      iex> Vector1.init(1885)
      ...> |> Enum.member?(1955)
      false
  """
  @spec member?(Vector1.t(), any) :: {:ok, boolean}
  def member?(%Vector1{x: x}, x), do: {:ok, true}
  def member?(_vector, _element), do: {:ok, false}

  @doc """
  Implements `reduce` for `Vector1` allowing it to be iterated.

  ## Example

      iex> Vector1.init(1885)
      ...> |> Enum.map(&Integer.to_string(&1, 16))
      ["75D"]
  """
  @spec reduce(Vector1.t(), Enumerable.acc(), Enumerable.reducer()) :: Enumerable.result()
  def reduce(_vector, {:halt, acc}, _fun), do: {:halted, acc}
  def reduce(vector, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(vector, &1, fun)}
  def reduce(%Vector1{x: nil}, {:cont, acc}, _fun), do: {:done, acc}

  def reduce(%Vector1{x: x} = vector, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Vector1{vector | x: nil}, fun.(x, acc), fun)

  @doc """
  Declines to implement `Enumerable.slice/1`.
  """
  @spec slice(Vector1.t()) :: {:error, atom}
  def slice(_vector), do: {:error, __MODULE__}
end
