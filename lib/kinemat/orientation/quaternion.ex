defimpl Kinemat.Orientation, for: Kinemat.Quaternion do
  alias Kinemat.{Quaternion, RotationMatrix, Euler, Orientation}
  alias Graphmath.Quatern

  @moduledoc """
  Implements the Orientation protocol for Quaternions.
  """

  @doc """
  Converts the Quaternion into a RotationMatrix.

  ## Examples

      This example comes from the [Graphmath tests](https://github.com/crertel/graphmath/blob/master/test/quatern/quatern_to_matrix_test.exs).

      iex> use Kinemat
      ...> Quaternion.init(~a(2)r, -0.25, 0.5, -0.25)
      ...> |> Orientation.to_rotation_matrix()
      %Kinemat.RotationMatrix{matrix: {
         0.375,  0.75,  2.125,
        -1.25,   0.75,  0.75,
        -1.875, -1.25,  0.375
      }}

  """
  @spec to_rotation_matrix(Quaternion.t) :: RotationMatrix.t
  def to_rotation_matrix(%Quaternion{w: w, x: x, y: y, z: z}) do
    {_, r} = Angle.to_radians(w)
    r
    |> Quatern.create(x, y, z)
    |> Quatern.to_rotation_matrix()
    |> RotationMatrix.init()
  end

  @doc """
  Does nothing, simply returns the Quaternion.
  """
  @spec to_quaternion(Quaternion.t) :: Quaternion.t
  def to_quaternion(orientation), do: orientation

  @doc """
  Converts the Quaternion to it's Euler rotations in the specified representation.

  ## Examples

      iex> use Kinemat
      ...> Quaternion.init(~a(0.978015)r, 0.135224, 0.137461, 0.0794041)
      ...> |> Orientation.to_euler()
      %Kinemat.Euler{representation: :xyz,
                     x: ~a(0.25639733655419217)r,
                     y: ~a(0.2945952073784124)r,
                     z: ~a(0.12377521877974283)r}
  """
  @spec to_euler(Quaternion.t, Euler.valid_representation) :: Euler.t
  def to_euler(orientation, representation \\ :xyz) do
    orientation
    |> Orientation.to_rotation_matrix()
    |> Orientation.to_euler(representation)
  end
end
