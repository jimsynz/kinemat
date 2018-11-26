defmodule Kinemat.Vector.Vector4 do
  alias __MODULE__
  defstruct x: 0, y: 0, z: 0, w: 0

  @type t :: %Vector4{x: number, y: number, z: number, w: number}

  @moduledoc """
  A 4-dimensional vector.
  """

  @doc """
  Creates a `Vector4` initialized with numeric values.

  ## Example

      iex> Vector4.init(1885, 1955, 1985, 2015)
      %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}
  """
  @spec init(number, number, number, number) :: Vector4.t()
  def init(x, y, z, w), do: %Vector4{x: x, y: y, z: z, w: w}

  @doc """
  Creates a `Vector4` initialized with zero values.

  ## Example

      iex> Vector4.zero()
      %Vector4{x: 0, y: 0, z: 0, w: 0}
  """
  @spec zero :: Vector4.t()
  def zero, do: init(0, 0, 0, 0)
end
