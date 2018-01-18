defmodule Kinemat.HomogeneousTransformation do
  use Kinemat

  @moduledoc """
  Converts a Frame into a 4x4 matrix of it's homogeneous transformation.
  """

  @type t ::
          {number, number, number, number, number, number, number, number,
           number, number, number, number, number, number, number, number}

  @doc """
  Converts a Frame into it's 4x4 matrix representation as a homogeneous transformation.

  ## Examples

      Creating a homogeneous transformation from a nil rotation and nil offset
      returns the identity matrix.

      iex> point = Cartesian.init(0.0, 0.0, 0.0)
      ...> orientation = Euler.init(:xyz, ~a(0), ~a(0), ~a(0))
      ...> Frame.init(point, orientation)
      ...> |> Kinemat.HomogeneousTransformation.to_homogeneous_transformation()
      {1.0, 0.0, 0.0, 0.0,
       0.0, 1.0, 0.0, 0.0,
       0.0, 0.0, 1.0, 0.0,
       0.0, 0.0, 0.0, 1.0}
  """
  @spec to_homogeneous_transformation(Frame.t()) :: t
  def to_homogeneous_transformation(%Frame{
        point: point,
        orientation: orientation
      }) do
    {m00, m01, m02, m10, m11, m12, m20, m21, m22} = matrix_from(orientation)
    {m03, m13, m23} = coords_from(point)

    {m00, m01, m02, m03, m10, m11, m12, m13, m20, m21, m22, m23, 0.0, 0.0, 0.0,
     1.0}
  end

  defp coords_from(point) do
    %{x: x, y: y, z: z} =
      point
      |> Point.to_cartesian()

    {x, y, z}
  end

  defp matrix_from(orientation) do
    %{matrix: matrix} =
      orientation
      |> Orientation.to_rotation_matrix()

    matrix
  end
end
