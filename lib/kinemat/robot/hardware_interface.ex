defmodule Kinemat.Robot.HardwareInterface do
  defstruct name: nil
  alias __MODULE__

  @moduledoc """
  Joint transmission hardware interface

  See [Hardware Interfaces on the ROS Wiki][1] for more information.

  1: http://wiki.ros.org/ros_control#Hardware_Interfaces
  """

  @type t :: %HardwareInterface{
          name: String.t()
        }

  @doc """
  Initialise a new hardware interface.
  """
  @spec init(String.t()) :: HardwareInterface.t()
  def init(name), do: %HardwareInterface{name: name}
end
