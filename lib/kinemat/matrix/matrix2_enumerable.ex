defimpl Enumerable, for: Kinemat.Matrix.Matrix2 do
  alias Kinemat.Matrix.Matrix2
  alias Kinemat.Vector.Vector2

  @moduledoc """
  Implements `Enumerable` for `Matrix2`.
  """

  @doc """
  Returns the number of elements in `Matrix2`.

  ## Example

      iex> [1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix2.zero())
      ...> |> Enum.count()
      4
  """
  @spec count(Matrix2.t()) :: {:ok, 4}
  def count(%Matrix2{}), do: {:ok, 4}

  @doc """
  Returns whether `element` is present in the `Matrix2`.

  ## Examples

      iex> [1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix2.zero())
      ...> |> Enum.member?(1885)
      true

      iex> [1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix2.zero())
      ...> |> Enum.member?(1.21)
      false
  """
  @spec member?(Matrix2.t(), any) :: {:ok, boolean}
  def member?(%Matrix2{x: %Vector2{x: x}}, x), do: {:ok, true}
  def member?(%Matrix2{x: %Vector2{y: y}}, y), do: {:ok, true}
  def member?(%Matrix2{y: %Vector2{x: x}}, x), do: {:ok, true}
  def member?(%Matrix2{y: %Vector2{y: y}}, y), do: {:ok, true}
  def member?(_matrix, _element), do: {:ok, false}

  @doc """
  Implements `reduce` for `Matrix2` allowing it to be iterated.

  ## Example

      iex> [1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix2.zero())
      ...> |> Enum.map(&Integer.to_string(&1, 16))
      ["75D", "7A3", "7C1", "7DF"]
  """
  @spec reduce(Matrix2.t(), Enumerable.acc(), Enumerable.reducer()) :: Enumerable.result()
  def reduce(_matrix, {:halt, acc}, _fun), do: {:halted, acc}
  def reduce(matrix, {:suspect, acc}, fun), do: {:suspended, acc, &reduce(matrix, &1, fun)}

  def reduce(
        %Matrix2{x: %Vector2{x: nil, y: nil}, y: %Vector2{x: nil, y: nil}},
        {:cont, acc},
        _fun
      ),
      do: {:done, acc}

  def reduce(%Matrix2{x: %Vector2{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix2{matrix | x: %Vector2{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix2{x: %Vector2{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix2{matrix | x: %Vector2{vector | y: nil}}, fun.(y, acc), fun)

  def reduce(%Matrix2{y: %Vector2{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix2{matrix | y: %Vector2{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix2{y: %Vector2{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix2{matrix | y: %Vector2{vector | y: nil}}, fun.(y, acc), fun)

  @doc """
  Declines to implement `Enumerable.slice/1`.
  """
  @spec slice(Matrix2.t()) :: {:error, atom}
  def slice(_matrix), do: {:error, __MODULE__}
end
