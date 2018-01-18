defmodule Kinemat.RotationMatrix do
  alias __MODULE__
  defstruct [:matrix]

  @moduledoc """
  Describes a 3 dimension orientation with a Rotation Matrix.
  """

  @type matrix3 ::
          {number, number, number, number, number, number, number, number,
           number}
  @type t :: %RotationMatrix{matrix: matrix3}

  @doc """
  Initialise a rotation matrix using the 9 values for a 3x3 matrix.

  ## Examples

      iex> use Kinemat
      ...> RotationMatrix.init({1, 0, 0, 0, 1, 0, 0, 0, 1})
      %Kinemat.RotationMatrix{matrix: {1, 0, 0, 0, 1, 0, 0, 0, 1}}
  """
  @spec init(matrix3) :: t
  def init({n0, n1, n2, n3, n4, n5, n6, n7, n8} = matrix)
      when is_number(n0) and is_number(n1) and is_number(n2) and is_number(n3) and
             is_number(n4) and is_number(n5) and is_number(n6) and is_number(n7) and
             is_number(n8) do
    %RotationMatrix{matrix: matrix}
  end

  @doc """
  Returns the matrix as a tuple.

  ## Examples

      iex> Euler.init(:xyz, ~a(30)d, ~a(20)d, ~a(15)d)
      ...> |> Orientation.to_rotation_matrix()
      ...> |> RotationMatrix.matrix()
      { 0.9076733711903687,  0.3893269128166894, -0.15669590354740334,
       -0.24321034680169396, 0.7922556402871195,  0.5596246310178333,
        0.3420201433256687, -0.46984631039295416, 0.8137976813493738}
  """
  @spec matrix(t) :: matrix3
  def matrix(%RotationMatrix{matrix: matrix}), do: matrix
end
