defprotocol Kinemat.Robot.Orientable do
  @moduledoc """
  Defines a protocol for setting the orientation of various parts of the robot.
  """
  alias Kinemat.Robot.Orientable
  alias Kinemat.Frame

  @doc """
  Set the orientation frame on the orientable.
  """
  @spec set(Orientable.t(), Frame.t()) :: Orientable.t()
  def set(orienable, orientation)

  @doc """
  Retrieve the orientation from the orientable.
  """
  @spec get(Orientable.t()) :: Frame.t()
  def get(orientable)
end
