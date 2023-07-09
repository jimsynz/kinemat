defimpl Kinemat.Point, for: Kinemat.Coordinates.Spherical do
  use Kinemat.Coordinates
  import Kinemat.Trig, only: [sin: 1, cos: 1]

  @moduledoc """
  Implements the point protocol for points in Spherical.
  """

  @doc """
  Convert a point in spherical space into cylindrical space.

  ## Examples

      iex> Spherical.init(8, ~a(30)d, ~a(20)d)
      ...> |> Kinemat.Point.to_cylindrical()
      %Cylindrical{
        azimuth: ~a(20)d,
        radial:  3.9999999999999996,
        vertical: 6.92820323027551}
  """
  @spec to_cylindrical(Spherical.t()) :: Cylindrical.t()
  def to_cylindrical(%Spherical{radial: r, azimuth: theta, polar: phi}) do
    theta1 = theta
    theta = phi

    r1 = r * sin(theta1)
    z = r * cos(theta1)
    Cylindrical.init(r1, theta, z)
  end

  @doc """
  Convert a point in spherical space into cartesian.

  ## Examples

      iex> Spherical.init(12, ~a(20)d, ~a(60)d)
      ...> |> Kinemat.Point.to_cartesian()
      %Cartesian{
        x: 2.052120859954013,
        y: 3.554377592712286,
        z: 11.276311449430901}
  """
  @spec to_cartesian(Spherical.t()) :: Cartesian.t()
  def to_cartesian(%Spherical{radial: r, azimuth: theta, polar: phi}) do
    x = r * sin(theta) * cos(phi)
    y = r * sin(theta) * sin(phi)
    z = r * cos(theta)
    Cartesian.init(x, y, z)
  end

  @doc """
  Does nothing, simply returns the spherical point.

  ## Examples

      iex> Spherical.init(12, ~a(20)d, ~a(60)d)
      ...> |> Kinemat.Point.to_spherical()
      %Spherical{
        azimuth: ~a(20)d,
        polar: ~a(60)d,
        radial: 12}
  """
  @spec to_spherical(Spherical.t()) :: Spherical.t()
  def to_spherical(point), do: point
end
