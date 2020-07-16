defmodule Kinemat.Robot.Visual do
  defstruct geometry: nil, material: nil, origin: nil
  alias Kinemat.{Frame, Geometry, Robot.Geometric, Robot.Material, Robot.Orientable, Robot.Visual}

  @moduledoc """
  A container for the visual properties of a Robot description.
  """

  @type t :: %Visual{
          geometry: Geometry.t(),
          origin: Point.t() | nil,
          material: Material.t() | nil
        }

  @doc """
  Initialise an empty Visual container.
  """
  @spec init :: Visual.t()
  def init, do: %Visual{}

  @doc """
  Set the origin of the visual geometry.
  """
  @spec origin(Visual.t(), Point.t()) :: Visual.t()
  def origin(%Visual{} = visual, origin),
    do: %Visual{visual | origin: origin}

  @doc """
  Set the material of this visual geometry.
  """
  @spec material(Visual.t(), Material.t()) :: Visual.t()
  def material(%Visual{} = visual, %Material{} = material),
    do: %Visual{visual | material: material}

  defimpl Geometric do
    def set(%Visual{} = visual, geometry),
      do: %Visual{visual | geometry: geometry}

    def get(%Visual{geometry: geometry}),
      do: geometry
  end

  defimpl Orientable do
    def set(%Visual{} = visual, %Frame{} = origin),
      do: %Visual{visual | origin: origin}

    def get(%Visual{origin: origin}), do: origin
  end
end
