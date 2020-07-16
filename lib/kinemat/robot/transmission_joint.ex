defmodule Kinemat.Robot.TransmissionJoint do
  defstruct name: nil, hardware_interfaces: []
  alias Kinemat.Robot.{HardwareInterface, TransmissionJoint}

  @moduledoc """
  Transmission Joint

  A joint that the transmission is connected to, specified by name and a number
  of hardware interfaces.
  """

  @type t :: %TransmissionJoint{
          name: String.t(),
          hardware_interfaces: [HardwareInterface.t()]
        }

  @doc """
  Initialise a transmission joint.
  """
  @spec init(String.t()) :: TransmissionJoint.t()
  def init(name), do: %TransmissionJoint{name: name}

  @doc """
  Set the hardware interfaces associated with the transmission joint.
  """
  @spec hardware_interfaces(TransmissionJoint.t(), [HardwareInterface.t()]) ::
          TransmissionJoint.t()
  def hardware_interfaces(%TransmissionJoint{} = joint, hardware_interfaces)
      when is_list(hardware_interfaces),
      do: %TransmissionJoint{joint | hardware_interfaces: hardware_interfaces}
end
