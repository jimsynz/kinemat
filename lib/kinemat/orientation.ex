defprotocol Kinemat.Orientation do
  alias Kinemat.{Orientation, Euler, RotationMatrix, Quaternion}

  @moduledoc """
  The Orientation protocol is used to convert between and manipulate the
  different orientations (Euler, RotationMatrix and Quaternion).
  """

  @type t :: Euler.t() | RotationMatrix.t() | Quaternion.t()

  @doc """
  Convert the Orientation into it's Rotation Matrix representation.
  """
  @spec to_rotation_matrix(Orientation.t()) :: RotationMatrix.t()
  def to_rotation_matrix(orientation)

  @doc """
  Convert the Orientation into it's Quaternion representation.
  """
  @spec to_quaternion(Orientation.t()) :: Quaternion.t()
  def to_quaternion(orientation)

  @doc """
  Convert the Orientation into it's Euler angle representation.

  Default representation is `:xyz`.
  """
  @spec to_euler(Orientation.t()) :: Euler.t()
  def to_euler(orientation)

  @doc """
  Convert the Orientation into it's Euler angle representation in the
  specified axis order.
  """
  @spec to_euler(Orientation.t(), Euler.valid_representation()) :: Euler.t()
  def to_euler(orientation, representation)
end
