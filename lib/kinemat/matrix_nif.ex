defmodule Kinemat.MatrixNif do
  use Rustler, otp_app: :kinemat, crate: :kinemat_matrix_nif

  @moduledoc false

  @type vectors :: vector1 | vector2 | vector3 | vector4
  @type vector1 :: {:vector1, number}
  @type vector2 :: {:vector2, number, number}
  @type vector3 :: {:vector3, number, number, number}
  @type vector4 :: {:vector4, number, number, number, number}

  @type matrices :: matrix2 | matrix3 | matrix4
  @type matrix2 :: {:matrix2, vector2, vector2}
  @type matrix3 :: {:matrix3, vector3, vector3, vector3}
  @type matrix4 :: {:matrix4, vector4, vector4, vector4, vector4}

  # When your NIF is loaded, it will override this function.
  # def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> vector1_add({:vector1, 1.0}, {:vector1, 2.0})
      {:ok, {:vector1, 3.0}}
  """
  @spec vector1_add(vector1, vector1) :: vector1
  def vector1_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from 'lhs'.

      iex> vector1_sub({:vector1, 1.0}, {:vector1, 2.0})
      {:ok, {:vector1, -1.0}}
  """
  @spec vector1_sub(vector1, vector1) :: vector1
  def vector1_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `vector1` by `n`.

      iex> vector1_mul({:vector1, 1.0}, 2.0)
      {:ok, {:vector1, 2.0}}
  """
  @spec vector1_mul(vector1, number) :: vector1
  def vector1_mul(_vector1, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `vector1` by `n`.

      iex> vector1_div({:vector1, 1.0}, 2.0)
      {:ok, {:vector1, 0.5}}
  """
  @spec vector1_div(vector1, number) :: vector1
  def vector1_div(_vector1, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `vector1` by `n`.

      iex> vector1_mod({:vector1, 3.0}, 2.0)
      {:ok, {:vector1, 1.0}}
  """
  @spec vector1_mod(vector1, number) :: vector1
  def vector1_mod(_vector1, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> vector2_add({:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0})
      {:ok, {:vector2, 4.0, 6.0}}
  """
  @spec vector2_add(vector2, vector2) :: vector2
  def vector2_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from 'lhs'.

      iex> vector2_sub({:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0})
      {:ok, {:vector2, -2.0, -2.0}}
  """
  @spec vector2_sub(vector2, vector2) :: vector2
  def vector2_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `vector2` by `n`.

      iex> vector2_mul({:vector2, 1.0, 2.0}, 2.0)
      {:ok, {:vector2, 2.0, 4.0}}
  """
  @spec vector2_mul(vector1, number) :: vector1
  def vector2_mul(_vector2, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `vector2` by `n`.

      iex> vector2_div({:vector2, 1.0, 2.0}, 2.0)
      {:ok, {:vector2, 0.5, 1.0}}
  """
  @spec vector2_div(vector1, number) :: vector1
  def vector2_div(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `vector2` by `n`.

      iex> vector2_mod({:vector2, 3.0, 2.0}, 2.0)
      {:ok, {:vector2, 1.0, 0.0}}
  """
  @spec vector2_mod(vector1, number) :: vector1
  def vector2_mod(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Perpendicular dot product of two `Vector2`.

      iex> vector2_perp_dot({:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0})
      {:ok, -2.0}
  """
  @spec vector2_perp_dot(vector2, vector2) :: {:ok, number}
  def vector2_perp_dot(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> vector3_add({:vector3, 1.0, 2.0, 3.0}, {:vector3, 4.0, 5.0, 6.0})
      {:ok, {:vector3, 5.0, 7.0, 9.0}}
  """
  @spec vector3_add(vector3, vector3) :: vector3
  def vector3_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from `lhs`.

      iex> vector3_sub({:vector3, 1.0, 2.0, 3.0}, {:vector3, 4.0, 5.0, 6.0})
      {:ok, {:vector3, -3.0, -3.0, -3.0}}
  """
  @spec vector3_sub(vector3, vector3) :: vector3
  def vector3_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `vector3` by `n`.

      iex> vector3_mul({:vector3, 1.0, 2.0, 3.0}, 2.0)
      {:ok, {:vector3, 2.0, 4.0, 6.0}}
  """
  @spec vector3_mul(vector3, number) :: vector3
  def vector3_mul(_vector3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `vector3` by `n`.

      iex> vector3_div({:vector3, 1.0, 2.0, 3.0}, 2.0)
      {:ok, {:vector3, 0.5, 1.0, 1.5}}
  """
  @spec vector3_div(vector3, number) :: vector3
  def vector3_div(_vector3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `vector3` by `n`.

      iex> vector3_mod({:vector3, 1.0, 2.0, 3.0}, 2.0)
      {:ok, {:vector3, 1.0, 0.0, 1.0}}
  """
  @spec vector3_mod(vector3, number) :: vector3
  def vector3_mod(_vector3, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Cross product of two `Vector3`.

      iex> vector3_cross({:vector3, 1.0, 2.0, 3.0}, {:vector3, 4.0, 5.0, 6.0})
      {:ok, {:vector3, -3.0, 6.0, -3.0}}
  """
  @spec vector3_cross(vector3, vector3) :: {:ok, vector3}
  def vector3_cross(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> vector4_add({:vector4, 1.0, 2.0, 3.0, 4.0}, {:vector4, 5.0, 6.0, 7.0, 8.0})
      {:ok, {:vector4, 6.0, 8.0, 10.0, 12.0}}
  """
  @spec vector4_add(vector4, vector4) :: vector4
  def vector4_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from `lhs`.

      iex> vector4_sub({:vector4, 1.0, 2.0, 3.0, 4.0}, {:vector4, 5.0, 6.0, 7.0, 8.0})
      {:ok, {:vector4, -4.0, -4.0, -4.0, -4.0}}
  """
  @spec vector4_sub(vector4, vector4) :: vector4
  def vector4_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `vector4` by `n`.

      iex> vector4_mul({:vector4, 1.0, 2.0, 3.0, 4.0}, 2.0)
      {:ok, {:vector4, 2.0, 4.0, 6.0, 8.0}}
  """
  @spec vector4_mul(vector4, number) :: vector4
  def vector4_mul(_vector4, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide a `vector4` by `n`.

      iex> vector4_div({:vector4, 1.0, 2.0, 3.0, 4.0}, 2.0)
      {:ok, {:vector4, 0.5, 1.0, 1.5, 2.0}}
  """
  @spec vector4_div(vector2, number) :: vector2
  def vector4_div(_vector4, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `vector4` by `n`.

      iex> vector4_mod({:vector4, 1.0, 2.0, 3.0, 4.0}, 2.0)
      {:ok, {:vector4, 1.0, 0.0, 1.0, 0.0}}
  """
  @spec vector4_mod(vector4, number) :: vector4
  def vector4_mod(_vector4, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Add `lhs` and `rhs` together.

      iex> matrix2_add({:matrix2, {:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0}}, {:matrix2, {:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0}})
      {:ok, {:matrix2, {:vector2, 2.0, 4.0}, {:vector2, 6.0, 8.0}}}
  """
  @spec matrix2_add(matrix2, matrix2) :: matrix2
  def matrix2_add(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Subtract `rhs` from `lhs`.

      iex> matrix2_sub({:matrix2, {:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0}}, {:matrix2, {:vector2, 5.0, 6.0}, {:vector2, 7.0, 8.0}})
      {:ok, {:matrix2, {:vector2, -4.0, -4.0}, {:vector2, -4.0, -4.0}}}
  """
  @spec matrix2_sub(matrix2, matrix2) :: matrix2
  def matrix2_sub(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Multiply `matrix2` by `n`.

      iex> matrix2_mul({:matrix2, {:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0}}, 4.0)
      {:ok, {:matrix2, {:vector2, 4.0, 8.0}, {:vector2, 12.0, 16.0}}}
  """
  @spec matrix2_mul(matrix2, number) :: matrix2
  def matrix2_mul(_matrix2, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Divide `matrix2` by `n`.

      iex> matrix2_div({:matrix2, {:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0}}, 4.0)
      {:ok, {:matrix2, {:vector2, 0.25, 0.5}, {:vector2, 0.75, 1.0}}}
  """
  @spec matrix2_div(matrix2, number) :: matrix2
  def matrix2_div(_matrix2, _n), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Modulo `matrix2` by `n`.

      iex> matrix2_mod({:matrix2, {:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0}}, 4.0)
      {:ok, {:matrix2, {:vector2, 1.0, 2.0}, {:vector2, 3.0, 0.0}}}
  """
  @spec matrix2_mod(matrix2, number) :: matrix2
  def matrix2_mod(_matrix2, _n), do: :erlang.nif_error(:nif_not_loaded)
end
