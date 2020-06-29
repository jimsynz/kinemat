defmodule Kinemat.Geometry.Sphere do
  defstruct radius: 0
  alias Kinemat.Geometry.Sphere

  @moduledoc """
  Describes a spherical geometry.
  """

  @type t :: %Sphere{radius: number}

  @doc """
  Initialise a sphere with the provided radius.
  """
  @spec init(number) :: Sphere.t()
  def init(radius) when is_number(radius), do: %Sphere{radius: radius}
end
