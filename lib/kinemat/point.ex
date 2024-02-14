defprotocol Kinemat.Point do
  alias Kinemat.{Point, Coordinates.Cartesian, Coordinates.Cylindrical, Coordinates.Spherical}

  @moduledoc """
  Describes a Point in 3 dimensional space.
  """

  @type t :: Cartesian.t() | Cylindrical.t() | Spherical.t()

  @doc """
  Convert the Point into it's cartesian representation.
  """
  @spec to_cartesian(Point.t()) :: Cartesian.t()
  def to_cartesian(point)

  @doc """
  Convert the Point into it's cylindrical representation.
  """
  @spec to_cylindrical(Point.t()) :: Cylindrical.t()
  def to_cylindrical(point)

  @doc """
  Convert the Point into it's spherical representation.
  """
  @spec to_spherical(Point.t()) :: Spherical.t()
  def to_spherical(point)
end
