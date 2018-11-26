defimpl Enumerable, for: Kinemat.Vector.Vector4 do
  alias Kinemat.Vector.Vector4

  @moduledoc """
  Implements `Enumerable` for `Vector4`.
  """

  @doc """
  Returns the number of elements in a `Vector4`.

  ## Example

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Enum.count()
      4
  """
  @spec count(Vector4.t()) :: {:ok, 4}
  def count(%Vector4{}), do: {:ok, 4}

  @doc """
  Returns whether `element` is present in the `Vector4`.

  ## Examples

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Enum.member?(1885)
      true

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Enum.member?(1.21)
      false
  """
  @spec member?(Vector4.t(), any) :: {:ok, boolean}
  def member?(%Vector4{x: x}, x), do: {:ok, true}
  def member?(%Vector4{y: y}, y), do: {:ok, true}
  def member?(%Vector4{z: z}, z), do: {:ok, true}
  def member?(%Vector4{w: w}, w), do: {:ok, true}
  def member?(_vector, _element), do: {:ok, false}

  @doc """
  Implements `reduce` for `Vector4` allowing it to be iterated.

  ## Example

      iex> Vector4.init(1885, 1955, 1985, 2015)
      ...> |> Enum.map(&Integer.to_string(&1, 16))
      ["75D", "7A3", "7C1", "7DF"]
  """
  @spec reduce(Vector4.t(), Enumerable.acc(), Enumerable.reducer()) :: Enumerable.result()
  def reduce(_vector, {:halt, acc}, _fun), do: {:halted, acc}
  def reduce(vector, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(vector, &1, fun)}
  def reduce(%Vector4{x: nil, y: nil, z: nil, w: nil}, {:cont, acc}, _fun), do: {:done, acc}

  def reduce(%Vector4{x: x} = vector, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Vector4{vector | x: nil}, fun.(x, acc), fun)

  def reduce(%Vector4{y: y} = vector, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Vector4{vector | y: nil}, fun.(y, acc), fun)

  def reduce(%Vector4{z: z} = vector, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Vector4{vector | z: nil}, fun.(z, acc), fun)

  def reduce(%Vector4{w: w} = vector, {:cont, acc}, fun) when is_number(w),
    do: reduce(%Vector4{vector | w: nil}, fun.(w, acc), fun)

  @doc """
  Declines to implement `Enumerable.slice/1`.
  """
  @spec slice(Vector4.t()) :: {:error, atom}
  def slice(_vector), do: {:error, __MODULE__}
end
