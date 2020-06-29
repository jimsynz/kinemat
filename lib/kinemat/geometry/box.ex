defmodule Kinemat.Geometry.Box do
  defstruct x: 0, y: 0, z: 0
  alias __MODULE__

  @moduledoc """
  A simple box of known width, height and depth.
  """

  @type t :: %Box{
          x: non_neg_integer,
          y: non_neg_integer,
          z: non_neg_integer
        }

  @doc """
  Create a new box.
  """
  @spec init(non_neg_integer, non_neg_integer, non_neg_integer) :: Box.t()
  def init(x, y, z), do: %Box{x: x, y: y, z: z}
end

defimpl Kinemat.Geometry, for: Kinemat.Geometry.Box do
  def is_geometry(_shape), do: true
end
