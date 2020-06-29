defmodule Kinemat.Robot.Visual do
  defstruct geometries: [], material_name: nil, origin: nil
  alias Kinemat.Robot.{Geometry, Point, Visual}

  @moduledoc """
  A container for the visual properties of a Robot description.
  """

  @type t :: %Visual{
          geometries: [Geometry.t()],
          origin: Point.t() | nil,
          material_name: String.t() | nil
        }

  @doc """
  Initialise an empty Visual container.
  """
  @spec init :: Visual.t()
  def init, do: %Visual{}

  @doc """
  Set the geometries to be stored in the container.
  """
  @spec geometries(Visual.t(), [Geometry.t()]) :: Visual.t()
  def geometries(%Visual{} = visual, geometries), do: %Visual{visual | geometries: geometries}

  @doc """
  Set the origin of the visual geometries.
  """
  @spec origin(Visual.t(), Point.t()) :: Visual.t()
  def origin(%Visual{} = visual, origin), do: %Visual{visual | origin: origin}

  @doc """
  Set the material name of this visual geometries.
  """
  @spec material_name(Visual.t(), String.t()) :: Visual.t()
  def material_name(%Visual{} = visual, material_name),
    do: %Visual{visual | material_name: material_name}
end
