defimpl Enumerable, for: Kinemat.Vector.Vector3 do
  alias Kinemat.Vector.Vector3

  @moduledoc """
  Implements `Enumerable` for `Vector3`.
  """

  @doc """
  Returns the number of elements in a `Vector3`.

  ## Example

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Enum.count()
      3
  """
  @spec count(Vector3.t()) :: {:ok, 3}
  def count(%Vector3{}), do: {:ok, 3}

  @doc """
  Returns whether `element` is present in the `Vector3`.

  ## Examples

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Enum.member?(1885)
      true

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Enum.member?(2015)
      false
  """
  @spec member?(Vector3.t(), any) :: {:ok, boolean}
  def member?(%Vector3{x: x}, x), do: {:ok, true}
  def member?(%Vector3{y: y}, y), do: {:ok, true}
  def member?(%Vector3{z: z}, z), do: {:ok, true}
  def member?(_vector, _element), do: {:ok, false}

  @doc """
  Implements `reduce` for `Vector3` allowing it to be iterated.

  ## Example

      iex> Vector3.init(1885, 1955, 1985)
      ...> |> Enum.map(&Integer.to_string(&1, 16))
      ["75D", "7A3", "7C1"]
  """
  @spec reduce(Vector3.t(), Enumerable.acc(), Enumerable.reducer()) :: Enumerable.result()
  def reduce(_vector, {:halt, acc}, _fun), do: {:halted, acc}
  def reduce(vector, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(vector, &1, fun)}
  def reduce(%Vector3{x: nil, y: nil, z: nil}, {:cont, acc}, _fun), do: {:done, acc}

  def reduce(%Vector3{x: x} = vector, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Vector3{vector | x: nil}, fun.(x, acc), fun)

  def reduce(%Vector3{y: y} = vector, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Vector3{vector | y: nil}, fun.(y, acc), fun)

  def reduce(%Vector3{z: z} = vector, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Vector3{vector | z: nil}, fun.(z, acc), fun)

  @doc """
  Declines to implement `Enumerable.slice/1`.
  """
  @spec slice(Vector3.t()) :: {:error, atom}
  def slice(_vector), do: {:error, __MODULE__}
end
