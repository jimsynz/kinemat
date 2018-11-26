defimpl Enumerable, for: Kinemat.Matrix.Matrix4 do
  alias Kinemat.Matrix.Matrix4
  alias Kinemat.Vector.Vector4

  @moduledoc """
  Implements `Enumerable` for `Matrix4`.
  """

  @doc """
  Returns the number of elements in `Matrix4`.

  ## Example

      iex> [1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix4.zero())
      ...> |> Enum.count()
      9
  """
  @spec count(Matrix4.t()) :: {:ok, 9}
  def count(%Matrix4{}), do: {:ok, 9}

  @doc """
  Returns whether `element` is present in the `Matrix4`.

  ## Examples

      iex> [1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix4.zero())
      ...> |> Enum.member?(1885)
      true

      iex> [1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix4.zero())
      ...> |> Enum.member?(1.21)
      false
  """
  @spec member?(Matrix4.t(), any) :: {:ok, boolean}
  def member?(%Matrix4{x: %Vector4{x: x}}, x), do: {:ok, true}
  def member?(%Matrix4{x: %Vector4{y: y}}, y), do: {:ok, true}
  def member?(%Matrix4{x: %Vector4{z: z}}, z), do: {:ok, true}
  def member?(%Matrix4{x: %Vector4{w: w}}, w), do: {:ok, true}
  def member?(%Matrix4{y: %Vector4{x: x}}, x), do: {:ok, true}
  def member?(%Matrix4{y: %Vector4{y: y}}, y), do: {:ok, true}
  def member?(%Matrix4{y: %Vector4{z: z}}, z), do: {:ok, true}
  def member?(%Matrix4{y: %Vector4{w: w}}, w), do: {:ok, true}
  def member?(%Matrix4{z: %Vector4{x: x}}, x), do: {:ok, true}
  def member?(%Matrix4{z: %Vector4{y: y}}, y), do: {:ok, true}
  def member?(%Matrix4{z: %Vector4{z: z}}, z), do: {:ok, true}
  def member?(%Matrix4{z: %Vector4{w: w}}, w), do: {:ok, true}
  def member?(%Matrix4{w: %Vector4{x: x}}, x), do: {:ok, true}
  def member?(%Matrix4{w: %Vector4{y: y}}, y), do: {:ok, true}
  def member?(%Matrix4{w: %Vector4{z: z}}, z), do: {:ok, true}
  def member?(%Matrix4{w: %Vector4{w: w}}, w), do: {:ok, true}
  def member?(_matrix, _element), do: {:ok, false}

  @doc """
  Implements `reduce` for `Matrix4` allowing it to be iterated.

  ## Example

      iex> [1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015, 1885, 1955, 1985, 2015]
      ...> |> Enum.into(Matrix4.zero())
      ...> |> Enum.map(&Integer.to_string(&1, 16))
      ["75D", "7A3", "7C1", "7DF", "75D", "7A3", "7C1", "7DF", "75D", "7A3", "7C1", "7DF", "75D", "7A3", "7C1", "7DF"]
  """
  @spec reduce(Matrix4.t(), Enumerable.acc(), Enumerable.reducer()) :: Enumerable.result()
  def reduce(_matrix, {:halt, acc}, _fun), do: {:halted, acc}
  def reduce(matrix, {:suspect, acc}, fun), do: {:suspended, acc, &reduce(matrix, &1, fun)}

  def reduce(
        %Matrix4{
          x: %Vector4{x: nil, y: nil, z: nil, w: nil},
          y: %Vector4{x: nil, y: nil, z: nil, w: nil},
          z: %Vector4{x: nil, y: nil, z: nil, w: nil},
          w: %Vector4{x: nil, y: nil, z: nil, w: nil}
        },
        {:cont, acc},
        _fun
      ),
      do: {:done, acc}

  def reduce(%Matrix4{x: %Vector4{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix4{matrix | x: %Vector4{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix4{x: %Vector4{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix4{matrix | x: %Vector4{vector | y: nil}}, fun.(y, acc), fun)

  def reduce(%Matrix4{x: %Vector4{z: z} = vector} = matrix, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Matrix4{matrix | x: %Vector4{vector | z: nil}}, fun.(z, acc), fun)

  def reduce(%Matrix4{x: %Vector4{w: w} = vector} = matrix, {:cont, acc}, fun) when is_number(w),
    do: reduce(%Matrix4{matrix | x: %Vector4{vector | w: nil}}, fun.(w, acc), fun)

  def reduce(%Matrix4{y: %Vector4{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix4{matrix | y: %Vector4{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix4{y: %Vector4{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix4{matrix | y: %Vector4{vector | y: nil}}, fun.(y, acc), fun)

  def reduce(%Matrix4{y: %Vector4{z: z} = vector} = matrix, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Matrix4{matrix | y: %Vector4{vector | z: nil}}, fun.(z, acc), fun)

  def reduce(%Matrix4{y: %Vector4{w: w} = vector} = matrix, {:cont, acc}, fun) when is_number(w),
    do: reduce(%Matrix4{matrix | y: %Vector4{vector | w: nil}}, fun.(w, acc), fun)

  def reduce(%Matrix4{z: %Vector4{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix4{matrix | z: %Vector4{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix4{z: %Vector4{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix4{matrix | z: %Vector4{vector | y: nil}}, fun.(y, acc), fun)

  def reduce(%Matrix4{z: %Vector4{z: z} = vector} = matrix, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Matrix4{matrix | z: %Vector4{vector | z: nil}}, fun.(z, acc), fun)

  def reduce(%Matrix4{z: %Vector4{w: w} = vector} = matrix, {:cont, acc}, fun) when is_number(w),
    do: reduce(%Matrix4{matrix | z: %Vector4{vector | w: nil}}, fun.(w, acc), fun)

  def reduce(%Matrix4{w: %Vector4{x: x} = vector} = matrix, {:cont, acc}, fun) when is_number(x),
    do: reduce(%Matrix4{matrix | w: %Vector4{vector | x: nil}}, fun.(x, acc), fun)

  def reduce(%Matrix4{w: %Vector4{y: y} = vector} = matrix, {:cont, acc}, fun) when is_number(y),
    do: reduce(%Matrix4{matrix | w: %Vector4{vector | y: nil}}, fun.(y, acc), fun)

  def reduce(%Matrix4{w: %Vector4{z: z} = vector} = matrix, {:cont, acc}, fun) when is_number(z),
    do: reduce(%Matrix4{matrix | w: %Vector4{vector | z: nil}}, fun.(z, acc), fun)

  def reduce(%Matrix4{w: %Vector4{w: w} = vector} = matrix, {:cont, acc}, fun) when is_number(w),
    do: reduce(%Matrix4{matrix | w: %Vector4{vector | w: nil}}, fun.(w, acc), fun)

  @doc """
  Declines to implement `Enumerable.slice/1`.
  """
  @spec slice(Matrix4.t()) :: {:error, atom}
  def slice(_matrix), do: {:error, __MODULE__}
end
