defprotocol Kinemat.Robot.Geometric do
  @moduledoc """
  Defines a protocol for setting a geometry on links, visuals, etc.
  """
  alias Kinemat.Robot.Geometric
  alias Kinemat.Geometry

  @doc """
  Set the geometry on a type capable of having a geometry.
  """
  @spec set(Geometric.t(), Geometry.t()) :: Proto.t()
  def set(geometric, geometry)

  @doc """
  Get the geometry from a type capable of having a geometry.
  """
  @spec get(Geometric.t()) :: Geometry.t()
  def get(geometric)
end
