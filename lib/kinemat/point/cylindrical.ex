defimpl Kinemat.Point, for: Kinemat.Coordinates.Cylindrical do
  use Kinemat.Coordinates
  alias Angle.Radian
  import :math, only: [atan: 1, pow: 2, sqrt: 1]
  import Kinemat.Trig, only: [sin: 1, cos: 1]

  @moduledoc """
  Implements the point protocol for points in Cylindrical space.
  """

  @doc """
  Does nothing, simply returns the cylindrical point.

  ## Examples

      iex> Cylindrical.init(3, ~a(10)d, 9)
      ...> |> Point.to_cylindrical()
      %Cylindrical{
        azimuth:  ~a(10)d,
        radial:   3,
        vertical: 9}
  """
  @spec to_cylindrical(Cylindrical.t()) :: Cylindrical.t()
  def to_cylindrical(point), do: point

  @doc """
  Convert a point in cylindrical space into a point in cartesian space.

  ## Examples

      iex> Cylindrical.init(3, ~a(10)d, 9)
      ...> |> Point.to_cartesian()
      %Cartesian{x: 2.954423259036624, y: 0.520944533000791, z: 9}
  """
  @spec to_cartesian(Cylindrical.t()) :: Cartesian.t()
  def to_cartesian(%Cylindrical{radial: r, azimuth: theta, vertical: z}) do
    x = cos(theta)
    y = sin(theta)
    Cartesian.init(x * r, y * r, z)
  end

  @doc """
  Convert a point in cylindrical space into a point in spherical space.

  ## Examples

      iex> Cylindrical.init(3, ~a(20)d, 4)
      ...> |> Point.to_spherical()
      %Spherical{
        azimuth: ~a(0.6435011087932844)r,
        polar:   ~a(20)d,
        radial:  5.0}
  """
  @spec to_spherical(Cylindrical.t()) :: Spherical.t()
  def to_spherical(%Cylindrical{radial: r0, azimuth: theta, vertical: z}) do
    r1 = sqrt(pow(r0, 2) + pow(z, 2))
    phi = theta
    theta = Radian.init(atan(r0 / z))
    Spherical.init(r1, theta, phi)
  end
end
