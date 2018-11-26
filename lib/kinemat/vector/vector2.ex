defmodule Kinemat.Vector.Vector2 do
  alias __MODULE__
  defstruct x: 0, y: 0

  @type t :: %Vector2{x: number, y: number}

  @moduledoc """
  A 2-dimensional vector.
  """

  @doc """
  Creates a `Vector2` initialized with numeric values.

  ## Example

      iex> Vector2.init(1955, 1985)
      %Vector2{x: 1955, y: 1985}
  """
  @spec init(number, number) :: Vector2.t()
  def init(x, y), do: %Vector2{x: x, y: y}

  @doc """
  Creates a `Vector2` initialized with zero values.

  ## Example

      iex> Vector2.zero()
      %Vector2{x: 0, y: 0}
  """
  @spec zero() :: Vector2.t()
  def zero, do: init(0, 0)
end
