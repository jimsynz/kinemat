defprotocol Kinemat.Geometry do
  @moduledoc """
  A geometric shape.
  """

  def is_geometry(_shape)
end

defimpl Kinemat.Geometry, for: Any do
  def is_geometry(_shape), do: false
end
