defmodule Kinemat.Vector.Vector3 do
  alias __MODULE__
  defstruct x: 0, y: 0, z: 0

  @type t :: %Vector3{x: number, y: number, z: number}

  @moduledoc """
  A 3-dimensional vector.
  """

  @doc """
  Creates a `Vector3` initialized with numeric values.

  ## Example

      iex> Vector3.init(1955, 1985, 2015)
      %Vector3{x: 1955, y: 1985, z: 2015}
  """
  @spec init(number, number, number) :: Vector3.t()
  def init(x, y, z), do: %Vector3{x: x, y: y, z: z}

  @doc """
  Creates a `Vector3` initialized with zero values.

  ## Example

      iex> Vector3.zero()
      %Vector3{x: 0, y: 0, z: 0}
  """
  @spec zero :: Vector3.t()
  def zero, do: init(0, 0, 0)
end
