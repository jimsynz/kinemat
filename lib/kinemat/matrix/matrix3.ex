defmodule Kinemat.Matrix.Matrix3 do
  alias __MODULE__
  alias Kinemat.Vector.Vector3
  defstruct x: Vector3.zero(), y: Vector3.zero(), z: Vector3.zero()

  @type t :: %Matrix3{x: Vector3.t(), y: Vector3.t(), z: Vector3.t()}

  @moduledoc """
  A 3x3 column matrix
  """

  @doc """
  Initialize a `Matrix3` from three `Vector3`s.

  ## Example

      iex> vec = Vector3.init(1955, 1985, 2015)
      ...> Matrix3.init(vec, vec, vec)
      %Matrix3{x: %Vector3{x: 1955, y: 1985, z: 2015}, y: %Vector3{x: 1955, y: 1985, z: 2015}, z: %Vector3{x: 1955, y: 1985, z: 2015}}
  """
  @spec init(Vector3.t(), Vector3.t(), Vector3.t()) :: Matrix3.t()
  def init(x, y, z), do: %Matrix3{x: x, y: y, z: z}

  @doc """
  Initialize a `Matrix3` from three zeroed `Vector3`s.

  ## Example

      iex> Matrix3.zero()
      %Matrix3{x: %Vector3{x: 0, y: 0, z: 0}, y: %Vector3{x: 0, y: 0, z: 0}, z: %Vector3{x: 0, y: 0, z: 0}}
  """
  @spec zero :: Matrix3.t()
  def zero, do: init(Vector3.zero(), Vector3.zero(), Vector3.zero())
end
