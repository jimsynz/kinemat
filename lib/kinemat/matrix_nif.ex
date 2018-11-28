defmodule Kinemat.MatrixNif do
  use Rustler, otp_app: :kinemat, crate: :kinemat_matrix_nif
  alias Kinemat.Matrix.{Matrix2.Matrix3, Matrix4}
  alias Kinemat.Vector.{Vector1, Vector2, Vector3, Vector4}

  @moduledoc false

  @doc """
  Add `lhs` and `rhs` together.

      iex> vector1_add(Vector1.init(1.0), Vector1.init(2.0))
      %Vector1{x: 3.0}
  """
  @spec vector1_add(Vector1.t(), Vector1.t()) :: {:ok, Vector1.t()}
  def vector1_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from 'lhs'.

      iex> vector1_sub(Vector1.init(1.0), Vector1.init(2.0))
      %Vector1{x: -1.0}
  """
  @spec vector1_sub(Vector1.t(), Vector1.t()) :: {:ok, Vector1.t()}
  def vector1_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `vector1` by `n`.

      iex> vector1_mul(Vector1.init(1.0), 2.0)
      %Vector1{x: 2.0}
  """
  @spec vector1_mul(Vector1.t(), float) :: {:ok, Vector1.t()}
  def vector1_mul(_vector1, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `vector1` by `n`.

      iex> vector1_div(Vector1.init(1.0), 2.0)
      %Vector1{x: 0.5}
  """
  @spec vector1_div(Vector1.t(), float) :: {:ok, Vector1.t()}
  def vector1_div(_vector1, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `vector1` by `n`.

      iex> vector1_mod(Vector1.init(3.0), 2.0)
      %Vector1{x: 1.0}
  """
  @spec vector1_mod(Vector1.t(), float) :: {:ok, Vector1.t()}
  def vector1_mod(_vector1, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> vector2_add(Vector2.init(1.0, 2.0), Vector2.init(3.0, 4.0))
      %Vector2{x: 4.0, y: 6.0}
  """
  @spec vector2_add(Vector2.t(), Vector2.t()) :: {:ok, Vector2.t()}
  def vector2_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from 'lhs'.

      iex> vector2_sub(Vector2.init(1.0, 2.0), Vector2.init(3.0, 4.0))
      %Vector2{x: -2.0, y: -2.0}
  """
  @spec vector2_sub(Vector2.t(), Vector2.t()) :: {:ok, Vector2.t()}
  def vector2_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `vector2` by `n`.

      iex> vector2_mul(Vector2.init(1.0, 2.0), 2.0)
      %Vector2{x: 2.0, y: 4.0}
  """
  @spec vector2_mul(Vector2.t(), float) :: {:ok, Vector2.t()}
  def vector2_mul(_vector2, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `vector2` by `n`.

      iex> vector2_div(Vector2.init(1.0, 2.0), 2.0)
      %Vector2{x: 0.5, y: 1.0}
  """
  @spec vector2_div(Vector2.t(), float) :: {:ok, Vector2.t()}
  def vector2_div(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `vector2` by `n`.

      iex> vector2_mod(Vector2.init(3.0, 2.0), 2.0)
      %Vector2{x: 1.0, y: 0.0}
  """
  @spec vector2_mod(Vector2.t(), Vector2.t()) :: {:ok, Vector2.t()}
  def vector2_mod(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Perpendicular dot product of two `Vector2`.

      iex> vector2_perp_dot(Vector2.init(1.0, 2.0), Vector2.init(3.0, 4.0))
      -2.0
  """
  @spec vector2_perp_dot(Vector2.t(), Vector2.t()) :: {:ok, float}
  def vector2_perp_dot(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> vector3_add(Vector3.init(1.0, 2.0, 3.0), Vector3.init(4.0, 5.0, 6.0))
      %Vector3{x: 5.0, y: 7.0, z: 9.0}
  """
  @spec vector3_add(Vector3.t(), Vector3.t()) :: {:ok, Vector3.t()}
  def vector3_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from `lhs`.

      iex> vector3_sub(Vector3.init(1.0, 2.0, 3.0), Vector3.init(4.0, 5.0, 6.0))
      %Vector3{x: -3.0, y: -3.0, z: -3.0}
  """
  @spec vector3_sub(Vector3.t(), Vector3.t()) :: {:ok, Vector3.t()}
  def vector3_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `vector3` by `n`.

      iex> vector3_mul(Vector3.init(1.0, 2.0, 3.0), 2.0)
      %Vector3{x: 2.0, y: 4.0, z: 6.0}
  """
  @spec vector3_mul(Vector3.t(), float) :: {:ok, Vector3.t()}
  def vector3_mul(_vector3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `vector3` by `n`.

      iex> vector3_div(Vector3.init(1.0, 2.0, 3.0), 2.0)
      %Vector3{x: 0.5, y: 1.0, z: 1.5}
  """
  @spec vector3_div(Vector3.t(), float) :: {:ok, Vector3.t()}
  def vector3_div(_vector3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `vector3` by `n`.

      iex> vector3_mod(Vector3.init(1.0, 2.0, 3.0), 2.0)
      %Vector3{x: 1.0, y: 0.0, z: 1.0}
  """
  @spec vector3_mod(Vector3.t(), float) :: {:ok, Vector3.t()}
  def vector3_mod(_vector3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Cross product of two `Vector3`.

      iex> vector3_cross(Vector3.init(1.0, 2.0, 3.0), Vector3.init(4.0, 5.0, 6.0))
      %Vector3{x: -3.0, y: 6.0, z: -3.0}
  """
  @spec vector3_cross(Vector3.t(), Vector3.t()) :: {:ok, Vector3.t()}
  def vector3_cross(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> vector4_add(Vector4.init(1.0, 2.0, 3.0, 4.0), Vector4.init(5.0, 6.0, 7.0, 8.0))
      %Vector4{x: 6.0, y: 8.0, z: 10.0, w: 12.0}
  """
  @spec vector4_add(Vector4.t(), Vector4.t()) :: {:ok, Vector4.t()}
  def vector4_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from `lhs`.

      iex> vector4_sub(Vector4.init(1.0, 2.0, 3.0, 4.0), Vector4.init(5.0, 6.0, 7.0, 8.0))
      %Vector4{x: -4.0, y: -4.0, z: -4.0, w: -4.0}
  """
  @spec vector4_sub(Vector4.t(), Vector4.t()) :: {:ok, Vector4.t()}
  def vector4_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `vector4` by `n`.

      iex> vector4_mul(Vector4.init(1.0, 2.0, 3.0, 4.0), 2.0)
      %Vector4{x: 2.0, y: 4.0, z: 6.0, w: 8.0}
  """
  @spec vector4_mul(Vector4.t(), float) :: {:ok, Vector4.t()}
  def vector4_mul(_vector4, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide a `vector4` by `n`.

      iex> vector4_div(Vector4.init(1.0, 2.0, 3.0, 4.0), 2.0)
      %Vector4{x: 0.5, y: 1.0, z: 1.5, w: 2.0}
  """
  @spec vector4_div(Vector4.t(), float) :: Vector4.t()
  def vector4_div(_vector4, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `vector4` by `n`.

      iex> vector4_mod(Vector4.init(1.0, 2.0, 3.0, 4.0), 2.0)
      %Vector4{x: 1.0, y: 0.0, z: 1.0, w: 0.0}
  """
  @spec vector4_mod(Vector4.t(), float) :: {:ok, Vector4.t()}
  def vector4_mod(_vector4, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> lhs = Matrix2.init(1.0, 2.0, 3.0, 4.0)
      ...> rhs = Matrix2.init(1.5, 2.5, 3.5, 4.5)
      ...> matrix2_add(lhs, rhs)
      %Matrix2{x: %Vector2{x: 2.5, y: 4.5}, y: %Vector2{x: 6.5, y: 8.5}}
  """
  @spec matrix2_add(Matrix2.t(), Matrix2.t()) :: {:ok, Matrix2.t()}
  def matrix2_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from `lhs`.

      iex> lhs = Matrix2.init(1.0, 2.0, 3.0, 4.0)
      ...> rhs = Matrix2.init(1.5, 2.5, 3.5, 4.5)
      ...> matrix2_sub(lhs, rhs)
      %Matrix2{x: %Vector2{x: -0.5, y: -0.5}, y: %Vector2{x: -0.5, y: -0.5}}
  """
  @spec matrix2_sub(Matrix2.t(), Matrix2.t()) :: {:ok, Matrix2.t()}
  def matrix2_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `matrix2` by `n`.

      iex> matrix2_mul(Matrix2.init(1.0, 2.0, 3.0, 4.0), 2.0)
      %Matrix2{x: %Vector2{x: 2.0, y: 4.0}, y: %Vector2{x: 6.0, y: 8.0}}
  """
  @spec matrix2_mul(Matrix2.t(), float) :: {:ok, Matrix2.t()}
  def matrix2_mul(_matrix2, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `matrix2` by `n`.

      iex> matrix2_div(Matrix2.init(1.0, 2.0, 3.0, 4.0), 2.0)
      %Matrix2{x: %Vector2{x: 0.5, y: 1.0}, y: %Vector2{x: 1.5, y: 2.0}}
  """
  @spec matrix2_div(Matrix2.t(), float) :: {:ok, Matrix2.t()}
  def matrix2_div(_matrix2, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `matrix2` by `n`.

      iex> matrix2_mod(Matrix2.init(1.0, 2.0, 3.0, 4.0), 2.0)
      %Matrix2{x: %Vector2{x: 1.0, y: 0.0}, y: %Vector2{x: 1.0, y: 0.0}}
  """
  @spec matrix2_mod(Matrix2.t(), float) :: {:ok, Matrix2.t()}
  def matrix2_mod(_matrix2, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> lhs = Matrix3.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
      ...> rhs = Matrix3.init(1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5)
      ...> matrix3_add(lhs, rhs)
      %Matrix3{x: %Vector3{x: 2.5, y: 4.5, z: 6.5}, y: %Vector3{x: 8.5, y: 10.5, z: 12.5}, z: %Vector3{x: 14.5, y: 16.5, z: 18.5}}
  """
  @spec matrix3_add(Matrix3.t(), Matrix3.t()) :: {:ok, Matrix3.t()}
  def matrix3_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from `lhs`.

      iex> lhs = Matrix3.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
      ...> rhs = Matrix3.init(1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5)
      ...> matrix3_sub(lhs, rhs)
      %Matrix3{x: %Vector3{x: -0.5, y: -0.5, z: -0.5}, y: %Vector3{x: -0.5, y: -0.5, z: -0.5}, z: %Vector3{x: -0.5, y: -0.5, z: -0.5}}
  """
  @spec matrix3_sub(Matrix3.t(), Matrix3.t()) :: {:ok, Matrix3.t()}
  def matrix3_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `matrix3` by `n`.

      iex> matrix3_mul(Matrix3.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0), 2.0)
      %Matrix3{x: %Vector3{x: 2.0, y: 4.0, z: 6.0}, y: %Vector3{x: 8.0, y: 10.0, z: 12.0}, z: %Vector3{x: 14.0, y: 16.0, z: 18.0}}
  """
  @spec matrix3_mul(Matrix3.t(), float) :: {:ok, Matrix3.t()}
  def matrix3_mul(_matrix3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `matrix3` by `n`.

      iex> matrix3_div(Matrix3.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0), 2.0)
      %Matrix3{x: %Vector3{x: 0.5, y: 1.0, z: 1.5}, y: %Vector3{x: 2.0, y: 2.5, z: 3.0}, z: %Vector3{x: 3.5, y: 4.0, z: 4.5}}
  """
  @spec matrix3_div(Matrix3.t(), float) :: {:ok, Matrix3.t()}
  def matrix3_div(_matrix3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `matrix3` by `n`.

      iex> matrix3_mod(Matrix3.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0), 2.0)
      %Matrix3{x: %Vector3{x: 1.0, y: 0.0, z: 1.0}, y: %Vector3{z: 0.0, x: 0.0, y: 1.0}, z: %Vector3{x: 1.0, y: 0.0, z: 1.0}}
  """
  @spec matrix3_mod(Matrix3.t(), float) :: {:ok, Matrix3.t()}
  def matrix3_mod(_matrix3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> lhs = Matrix4.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0)
      ...> rhs = Matrix4.init(1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5, 13.5, 14.5, 15.5, 16.5)
      ...> matrix4_add(lhs, rhs)
      %Matrix4{w: %Vector4{w: 32.5, x: 26.5, y: 28.5, z: 30.5}, x: %Vector4{x: 2.5, y: 4.5, z: 6.5, w: 8.5}, y: %Vector4{w: 16.5, x: 10.5, y: 12.5, z: 14.5}, z: %Vector4{w: 24.5, x: 18.5, y: 20.5, z: 22.5}}
  """
  @spec matrix4_add(Matrix4.t(), Matrix4.t()) :: {:ok, Matrix4.t()}
  def matrix4_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from `lhs`.

      iex> lhs = Matrix4.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0)
      ...> rhs = Matrix4.init(1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5, 13.5, 14.5, 15.5, 16.5)
      ...> matrix4_sub(lhs, rhs)
      %Matrix4{w: %Vector4{w: -0.5, x: -0.5, y: -0.5, z: -0.5}, x: %Vector4{x: -0.5, y: -0.5, z: -0.5, w: -0.5}, y: %Vector4{x: -0.5, y: -0.5, z: -0.5, w: -0.5}, z: %Vector4{x: -0.5, y: -0.5, z: -0.5, w: -0.5}}
  """
  @spec matrix4_sub(Matrix4.t(), Matrix4.t()) :: {:ok, Matrix4.t()}
  def matrix4_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `matrix4` by `n`.

      iex> matrix4_mul(Matrix4.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0), 2.0)
      %Matrix4{w: %Vector4{w: 32.0, x: 26.0, y: 28.0, z: 30.0}, x: %Vector4{x: 2.0, y: 4.0, z: 6.0, w: 8.0}, y: %Vector4{w: 16.0, x: 10.0, y: 12.0, z: 14.0}, z: %Vector4{w: 24.0, x: 18.0, y: 20.0, z: 22.0}}
  """
  @spec matrix4_mul(Matrix4.t(), float) :: {:ok, Matrix4.t()}
  def matrix4_mul(_matrix4, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `matrix4` by `n`.

      iex> matrix4_div(Matrix4.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0), 2.0)
      %Matrix4{w: %Vector4{w: 8.0, x: 6.5, y: 7.0, z: 7.5}, x: %Vector4{x: 0.5, y: 1.0, z: 1.5, w: 2.0}, y: %Vector4{w: 4.0, x: 2.5, y: 3.0, z: 3.5}, z: %Vector4{w: 6.0, x: 4.5, y: 5.0, z: 5.5}}
  """
  @spec matrix4_div(Matrix4.t(), float) :: {:ok, Matrix4.t()}
  def matrix4_div(_matrix4, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `matrix4` by `n`.

      iex> matrix4_mod(Matrix4.init(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0), 2.0)
      %Matrix4{x: %Vector4{w: 0.0, x: 1.0, y: 0.0, z: 1.0}, z: %Vector4{w: 0.0, x: 1.0, y: 0.0, z: 1.0}, w: %Vector4{w: 0.0, x: 1.0, y: 0.0, z: 1.0}, y: %Vector4{w: 0.0, x: 1.0, y: 0.0, z: 1.0}}
  """
  @spec matrix4_mod(Matrix4.t(), float) :: {:ok, Matrix4.t()}
  def matrix4_mod(_matrix4, _n), do: :erlang.nif_error(:nif_not_loaded)
end
