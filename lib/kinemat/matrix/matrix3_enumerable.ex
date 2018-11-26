defimpl Enumerable, for: Kinemat.Matrix.Matrix3 do
  alias Kinemat.Matrix.Matrix3
  alias Kinemat.Vector.Vector3

  @moduledoc """
  Implements `Enumerable` for `Matrix3`.
  """

  @doc """
  Returns the number of elements in `Matrix3`.

  ## Example

      iex> [1885, 1955, 1985, 1885, 1955, 1985, 1885, 1955, 1985]
      ...> |> Enum.into(Matrix3.zero())
      ...> |> Enum.count()
      9
  """
  @spec count(Matrix3.t()) :: {:ok, 9}
  def count(%Matrix3{}), do: {:ok, 9}

  @doc """
  Returns whether `element` is present in the `Matrix3`.

  ## Examples

      iex> [1885, 1955, 1985, 1885, 1955, 1985, 1885, 1955, 1985]
      ...> |> Enum.into(Matrix3.zero())
      ...> |> Enum.member?(1885)
      true

      iex> [1885, 1955, 1985, 1885, 1955, 1985, 1885, 1955, 1985]
      ...> |> Enum.into(Matrix3.zero())
      ...> |> Enum.member?(1.21)
      false
  """
  @spec member?(Matrix3.t(), any) :: {:ok, boolean}
  def member?(%Matrix3{x: %Vector3{x: x}}, x), do: {:ok, true}
  def member?(%Matrix3{x: %Vector3{y: y}}, y), do: {:ok, true}
  def member?(%Matrix3{x: %Vector3{z: z}}, z), do: {:ok, true}
  def member?(%Matrix3{y: %Vector3{x: x}}, x), do: {:ok, true}
  def member?(%Matrix3{y: %Vector3{y: y}}, y), do: {:ok, true}
  def member?(%Matrix3{y: %Vector3{z: z}}, z), do: {:ok, true}
  def member?(%Matrix3{z: %Vector3{x: x}}, x), do: {:ok, true}
  def member?(%Matrix3{z: %Vector3{y: y}}, y), do: {:ok, true}
  def member?(%Matrix3{z: %Vector3{z: z}}, z), do: {:ok, true}
  def member?(_matrix, _element), do: {:ok, false}

  @doc """
  Implements `reduce` for `Matrix3` allowing it to be iterated.

  ## Example

      iex> [1885, 1955, 1985, 1885, 1955, 1985, 1885, 1955, 1985]
      ...> |> Enum.into(Matrix3.zero())
      ...> |> Enum.map(&Integer.to_string(&1, 16))
      ["75D", "7A3", "7C1", "75D", "7A3", "7C1", "75D", "7A3", "7C1"]
  """
  @spec reduce(Matrix3.t(), Enumerable.acc(), Enumerable.reducer()) :: Enumerable.result()
  def reduce(_matrix, {:halt, acc}, _fun), do: {:halted, acc}
  def reduce(matrix, {:suspect, acc}, fun), do: {:suspended, acc, &reduce(matrix, &1, fun)}

  def reduce(
        %Matrix3{
          x: %Vector3{x: nil, y: nil, z: nil},
          y: %Vector3{x: nil, y: nil, z: nil},
          z: %Vector3{x: nil, y: nil, z: nil}
        },
        {:cont, acc},
        _fun
      ),
      do: {:done, acc}

  def reduce(%Matrix3{x: %Vector3{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix3{matrix | x: %Vector3{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix3{x: %Vector3{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix3{matrix | x: %Vector3{vector | y: nil}}, fun.(y, acc), fun)

  def reduce(%Matrix3{x: %Vector3{z: z} = vector} = matrix, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Matrix3{matrix | x: %Vector3{vector | z: nil}}, fun.(z, acc), fun)

  def reduce(%Matrix3{y: %Vector3{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix3{matrix | y: %Vector3{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix3{y: %Vector3{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix3{matrix | y: %Vector3{vector | y: nil}}, fun.(y, acc), fun)

  def reduce(%Matrix3{y: %Vector3{z: z} = vector} = matrix, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Matrix3{matrix | y: %Vector3{vector | z: nil}}, fun.(z, acc), fun)

  def reduce(%Matrix3{z: %Vector3{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix3{matrix | z: %Vector3{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix3{z: %Vector3{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix3{matrix | z: %Vector3{vector | y: nil}}, fun.(y, acc), fun)

  def reduce(%Matrix3{z: %Vector3{z: z} = vector} = matrix, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Matrix3{matrix | z: %Vector3{vector | z: nil}}, fun.(z, acc), fun)

  @doc """
  Declines to implement `Enumerable.slice/1`.
  """
  @spec slice(Matrix3.t()) :: {:error, atom}
  def slice(_matrix), do: {:error, __MODULE__}
end
