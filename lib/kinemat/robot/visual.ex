defmodule Kinemat.Robot.Visual do
  defstruct geometry: nil, material_name: nil, origin: nil
  alias Kinemat.{Frame, Geometry, Robot.Geometric, Robot.Orientable, Robot.Visual}

  @moduledoc """
  A container for the visual properties of a Robot description.
  """

  @type t :: %Visual{
          geometry: Geometry.t(),
          origin: Point.t() | nil,
          material_name: String.t() | nil
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
  Set the material name of this visual geometry.
  """
  @spec material_name(Visual.t(), String.t()) :: Visual.t()
  def material_name(%Visual{} = visual, material_name),
    do: %Visual{visual | material_name: material_name}

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
