defmodule Kinemat.Robot.Actuator do
  defstruct name: nil, mechanical_reduction: nil, hardware_interfaces: []
  alias Kinemat.Robot.{Actuator, HardwareInterface}

  @moduledoc """
  A transmission actuator

  An actuator that a transmission is connected to with optional mechanical
  reduction and hardware interfaces.
  """

  @type t :: %Actuator{
          name: String.t(),
          mechanical_reduction: number | nil,
          hardware_interfaces: [HardwareInterface.t()]
        }

  @doc """
  Initialise a new actuator by `name`.
  """
  @spec init(String.t()) :: Actuator.t()
  def init(name), do: %Actuator{name: name}

  @doc """
  Set the mechanical reduction of the actuator.
  """
  @spec mechanical_reduction(Actuator.t(), number) :: Actuator.t()
  def mechanical_reduction(%Actuator{} = actuator, mechanical_reduction)
      when is_number(mechanical_reduction),
      do: %Actuator{actuator | mechanical_reduction: mechanical_reduction}

  @doc """
  Set the hardware interfaces of the actuator.
  """
  @spec hardware_interfaces(Actuator.t(), [HardwareInterface.t()]) :: Actuator.t()
  def hardware_interfaces(%Actuator{} = actuator, hardware_interfaces)
      when is_list(hardware_interfaces),
      do: %Actuator{actuator | hardware_interfaces: hardware_interfaces}
end
