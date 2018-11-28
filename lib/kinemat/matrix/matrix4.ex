defmodule Kinemat.Matrix.Matrix4 do
  alias __MODULE__
  alias Kinemat.MatrixNif
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
  Initialize a `Matrix4` from 16 numbers.

  ## Example

      iex> Matrix4.init(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
      %Matrix4{x: %Vector4{x: 1, y: 2, z: 3, w: 4}, y: %Vector4{x: 5, y: 6, z: 7, w: 8}, z: %Vector4{x: 9, y: 10, z: 11, w: 12}, w: %Vector4{x: 13, y: 14, z: 15, w: 16}}
  """
  @spec init(
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number,
          number
        ) :: Matrix4.t()
  def init(xx, xy, xz, xw, yx, yy, yz, yw, zx, zy, zz, zw, wx, wy, wz, ww),
    do: %Matrix4{
      x: Vector4.init(xx, xy, xz, xw),
      y: Vector4.init(yx, yy, yz, yw),
      z: Vector4.init(zx, zy, zz, zw),
      w: Vector4.init(wx, wy, wz, ww)
    }

  @doc """
  Initialize a `Matrix4` from four zeroed `Vector4`s.

  ## Example

      iex> Matrix4.zero()
      %Matrix4{x: %Vector4{x: 0, y: 0, z: 0, w: 0}, y: %Vector4{x: 0, y: 0, z: 0, w: 0}, z: %Vector4{x: 0, y: 0, z: 0, w: 0}, w: %Vector4{x: 0, y: 0, z: 0, w: 0}}
  """
  @spec zero :: Matrix4.t()
  def zero, do: init(Vector4.zero(), Vector4.zero(), Vector4.zero(), Vector4.zero())

  @doc """
  Test functions for benchmarks.

      iex> Matrix4.elixir_mult(Matrix4.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0), 16.0)
      Matrix4.rust_mult(Matrix4.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0), 16.0)

  """
  def elixir_mult(
        %Matrix4{
          x: %Vector4{x: xx, y: xy, z: xz, w: xw},
          y: %Vector4{x: yx, y: yy, z: yz, w: yw},
          z: %Vector4{x: zx, y: zy, z: zz, w: zw},
          w: %Vector4{x: wx, y: wy, z: wz, w: ww}
        },
        n
      ) do
    Matrix4.init(
      xx * n,
      xy * n,
      xz * n,
      xw * n,
      yx * n,
      yy * n,
      yz * n,
      yw * n,
      zx * n,
      zy * n,
      zz * n,
      zw * n,
      wx * n,
      wy * n,
      wz * n,
      ww * n
    )
  end

  def rust_mult(matrix, n), do: MatrixNif.matrix4_mul(matrix, n)
end
