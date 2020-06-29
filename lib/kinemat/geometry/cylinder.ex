defmodule Kinemat.Geometry.Cylinder do
  defstruct length: 0, radius: 0
  alias __MODULE__

  @type t :: %Cylinder{
          length: non_neg_integer,
          radius: non_neg_integer
        }

  @moduledoc """
  Represents a simple cylinder of known length and radius.
  """

  @doc """
  Create a new cylinder.
  """
  @spec init(non_neg_integer, non_neg_integer) :: Kinemat.Geometry.Cylinder.t()
  def init(lenght, radius), do: %Cylinder{length: lenght, radius: radius}
end

defimpl Kinemat.Geometry, for: Kinemat.Geometry.Cylinder do
  def is_geometry(_shape), do: true
end
