defimpl Kinemat.Point, for: Kinemat.Cartesian do
  import :math, only: [pow: 2, sqrt: 1, atan: 1, acos: 1]
  alias Kinemat.{Cartesian, Cylindrical, Spherical}
  alias Angle.Radian

  @doc """
  Does nothing, simply returns the existing cartesian coordinates.

  ## Examples

      iex> Kinemat.Cartesian.init(1,2,3)
      ...> |> Kinemat.Point.to_cartesian()
      %Kinemat.Cartesian{x: 1, y: 2, z: 3}
  """
  @spec to_cartesian(Cartesian.t) :: Cartesian.t
  def to_cartesian(%Cartesian{} = point), do: point

  @doc """
  Converts the cartesian coordinates to cylindrical coordinates.

  ## Examples

      iex> Kinemat.Cartesian.init(3, 4, 7)
      ...> |> Kinemat.Point.to_cylindrical()
      %Kinemat.Cylindrical{
        radial:   5.0,
        azimuth:  %Angle{r: 0.9272952180016122},
        vertical: 7}
  """
  @spec to_cylindrical(Cartesian.t) :: Cylindrical.t
  def to_cylindrical(%Cartesian{x: x, y: y, z: z}) do
    r     = sqrt(pow(x, 2) + pow(y, 2))
    theta = Radian.init(atan(y / x))
    Cylindrical.init(r, theta, z)
  end

  @doc """
  Converts the cartesian coordiantes to sperical coordinates.

  ## Examples

      iex> Kinemat.Cartesian.init(2,3,8)
      ...> |> Kinemat.Point.to_spherical()
      %Kinemat.Spherical{
        radial:  8.774964387392123,
        azimuth: %Angle{r: 0.4234308319224211},
        polar:   %Angle{r: 0.982793723247329}}
  """
  @spec to_spherical(Cartesian.t) :: Sperical.t
  def to_spherical(%Cartesian{x: x, y: y, z: z}) do
    rho   = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
    theta = Radian.init(acos(z / rho))
    phi   = Radian.init(atan(y / x))
    Spherical.init(rho, theta, phi)
  end
end
