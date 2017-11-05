defimpl Kinemat.Orientation, for: Kinemat.Euler do
  alias Kinemat.{Euler, RotationMatrix, Quaternion, Orientation}

  @moduledoc """
  Implements the Orientation protocol for Euler angles.
  """

  @doc """
  Converts the euler angles to a rotation matrix.

  ## Examples

      iex> Euler.init(:xyz, ~a(30)d, ~a(15)d, ~a(20)d)
      ...> |> Orientation.to_rotation_matrix()
      %Kinemat.RotationMatrix{matrix: {
         0.9076733711903687,   0.41780330612687083, -0.03961626713065605,
        -0.33036608954935215,  0.7695370178986853,   0.5465080282662533,
         0.25881904510252074, -0.4829629131445341,   0.8365163037378079}}
  """
  @spec to_rotation_matrix(Euler.t) :: RotationMatrix.t
  def to_rotation_matrix(euler), do: Euler.ToRotationMatrix.to_rotation_matrix(euler)

  @doc """
  Convert the euler angle into quaternion.

  ## Examples

      This value is confirmed using [Wolfram Alpha](http://bit.ly/2mmhmHF)

      iex> Euler.init(:xyz, ~a(30)d, ~a(15)d, ~a(20)d)
      ...> |> Orientation.to_quaternion()
      %Kinemat.Quaternion{w: ~a(0.9372468582005039)r, x: 0.27459973122432013,
                          y: 0.07960424450132775,    z: 0.19956572516889892}
  """
  @spec to_quaternion(Euler.t) :: Quaternion.t
  def to_quaternion(orientation), do: Euler.ToQuaternion.to_quaternion(orientation)

  @doc """
  Convert the Euler from one representation to another.

  If the target representation is the same as the existing one, then nothing is done.

  ## Examples

      iex> Euler.init(:xyz, ~a(30)d, ~a(15)d, ~a(20)d)
      ...> |> Orientation.to_euler(:zyx)
      %Kinemat.Euler{representation: :zyx,
                     x: %Angle{r: -0.5235987755982988},
                     y: %Angle{r: -0.2617993877991494},
                     z: %Angle{r: -0.3490658503988659}}
  """
  @spec to_euler(Euler.t) :: Euler.t
  def to_euler(%Euler{} = orientation), do: orientation

  @spec to_euler(Euler.t, Euler.valid_representation) :: Euler.t
  def to_euler(%Euler{representation: r} = orientation, representation) when r == representation, do: orientation
  def to_euler(orientation, representation) do
    orientation
    |> Orientation.to_rotation_matrix()
    |> Orientation.to_euler(representation)
  end
end
