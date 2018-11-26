defmodule Kinemat.Matrix.Matrix4 do
  alias __MODULE__
  alias Kinemat.Vector.Vector4
  defstruct x: Vector4.zero(), y: Vector4.zero(), z: Vector4.zero(), w: Vector4.zero()

  @type t :: %Matrix4{x: Vector4.t(), y: Vector4.t(), z: Vector4.t(), w: Vector4.t()}

  @moduledoc """
  A 4x4 column matrix
  """

  @doc """
  Initialize a `Matrix4` from four `Vector4`s.

  ## Example

      iex> vec = Vector4.init(1885, 1955, 1985, 2015)
      ...> Matrix4.init(vec, vec, vec, vec)
      %Matrix4{x: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, y: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, z: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}, w: %Vector4{x: 1885, y: 1955, z: 1985, w: 2015}}
  """
  @spec init(Vector4.t(), Vector4.t(), Vector4.t(), Vector4.t()) :: Matrix4.t()
  def init(x, y, z, w), do: %Matrix4{x: x, y: y, z: z, w: w}

  @doc """
  Initialize a `Matrix4` from four zeroed `Vector4`s.

  ## Example

      iex> Matrix4.zero()
      %Matrix4{x: %Vector4{x: 0, y: 0, z: 0, w: 0}, y: %Vector4{x: 0, y: 0, z: 0, w: 0}, z: %Vector4{x: 0, y: 0, z: 0, w: 0}, w: %Vector4{x: 0, y: 0, z: 0, w: 0}}
  """
  @spec zero :: Matrix4.t()
  def zero, do: init(Vector4.zero(), Vector4.zero(), Vector4.zero(), Vector4.zero())
end
