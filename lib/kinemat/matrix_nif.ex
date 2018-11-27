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
  Perpendicular dot product of two `Vector2`.

      iex> MatrixNif.vector2_perp_dot({:vector2, 1.0, 2.0}, {:vector2, 3.0, 4.0})
      {:ok, -2.0}
  """
  def vector2_perp_dot(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Cross product of two `Vector3`.

      iex> MatrixNif.vector3_cross({:vector3, 1.0, 2.0, 3.0}, {:vector3, 4.0, 5.0, 6.0})
      {:ok, {:vector3, -3.0, 6.0, -3.0}}
  """
  def vector3_cross(_lhs, _rhs), do: :erlang.nif_error(:nif_not_loaded)
end
