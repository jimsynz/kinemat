defimpl Kinemat.Orientation, for: Kinemat.Orientations.RotationMatrix do
  use Kinemat.Orientations
  alias Angle.Radian
  alias Graphmath.Quatern

  @moduledoc """
  Implements the Orientation protocol for rotation matrices.
  """

  @doc """
  Does nothing, simply returns the rotation matrix.
  """
  @spec to_rotation_matrix(RotationMatrix.t()) :: RotationMatrix.t()
  def to_rotation_matrix(orientation), do: orientation

  @doc """
  Converts the rotation matrix into a Quaternion.

  ## Examples

    iex> {0, 1, 0, 1, 0, 0, 0, 0, -1}
    ...> |> RotationMatrix.init()
    ...> |> Orientation.to_quaternion()
    %Quaternion{w: ~a(0.7071067811865476)r, x: 0.7071067811865475, y: 0.0, z: 0.0}
  """
  @spec to_quaternion(RotationMatrix.t()) :: Quaternion.t()
  def to_quaternion(%RotationMatrix{matrix: matrix}) do
    {w, x, y, z} =
      matrix
      |> Quatern.from_rotation_matrix()

    Quaternion.init(Radian.init(w), x, y, z)
  end

  @doc """
  Converts the rotation matrix to it's Euler representation.

  ## Examples

    iex> {0, 1, 0, 1, 0, 0, 0, 0, -1}
    ...> |> RotationMatrix.init()
    ...> |> Orientation.to_euler()
    %Euler{representation: :xyz,
           x: ~a(3.141592653589793)r,
           y: ~a(0),
           z: ~a(-1.5707963267948966)r}
  """
  @spec to_euler(RotationMatrix.t()) :: Euler.t()
  def to_euler(orientation), do: RotationMatrix.ToEuler.to_euler(orientation, :xyz)

  @spec to_euler(RotationMatrix.t(), Euler.valid_representation()) :: Euler.t()
  def to_euler(orientation, representation),
    do: RotationMatrix.ToEuler.to_euler(orientation, representation)
end
