defmodule Kinemat.Matrix.Matrix2 do
  alias __MODULE__
  alias Kinemat.Vector.Vector2
  defstruct x: Vector2.zero(), y: Vector2.zero()

  @type t :: %Matrix2{x: Vector2.t(), y: Vector2.t()}

  @moduledoc """
  A 2x2 column matrix
  """

  @doc """
  Initialize a `Matrix2` from two `Vector2`s.

  ## Example

      iex> Matrix2.init(Vector2.init(1885, 1955), Vector2.init(1985, 2015))
      %Matrix2{x: %Vector2{x: 1885, y: 1955}, y: %Vector2{x: 1985, y: 2015}}
  """
  @spec init(Vector2.t(), Vector2.t()) :: Matrix2.t()
  def init(x, y), do: %Matrix2{x: x, y: y}

  @doc """
  Initialize a `Matrix2` from four numbers.

  ## Example

      iex> Matrix2.init(1885, 1955, 1985, 2015)
      %Matrix2{x: %Vector2{x: 1885, y: 1955}, y: %Vector2{x: 1985, y: 2015}}
  """
  @spec init(number, number, number, number) :: Matrix2.t()
  def init(x, y, z, w), do: %Matrix2{x: Vector2.init(x, y), y: Vector2.init(z, w)}

  @doc """
  Initialize a `Matrix2` from zeroed `Vector2`s.

  ## Example

      iex> Matrix2.zero()
      %Matrix2{x: %Vector2{x: 0, y: 0}, y: %Vector2{x: 0, y: 0}}
  """
  @spec zero :: Matrix2.t()
  def zero, do: init(Vector2.zero(), Vector2.zero())
end
