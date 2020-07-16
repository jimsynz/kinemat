defmodule Kinemat.Robot.Transmission do
  defstruct name: nil, type: nil, joints: [], actuators: []
  alias Kinemat.Robot.Transmission

  @moduledoc """
  URDF Transmissions

  As per the spec:

  > The transmission element is an extension to the URDF robot description model
  > that is used to describe the relationship between an actuator and a joint.
  > This allows one to model concepts such as gear ratios and parallel linkages.
  > A transmission transforms efforts/flow variables such that their product -
  > power - remains constant. Multiple actuators may be linked to multiple
  > joints through complex transmission.
  """

  @type t :: %Transmission{
          name: String.t(),
          type: String.t() | nil,
          joints: [Transmission.Joint.t()],
          actuators: [Transmission.Actuator.t()]
        }

  @doc """
  Initialises a new transmission.

  Every transmission must have at least a `name`.
  """
  @spec init(String.t()) :: Transmission.t()
  def init(name), do: %Transmission{name: name}

  @doc """
  Set the transmission type
  """
  @spec type(Transmission.t(), String.t()) :: Transmission.t()
  def type(%Transmission{} = transmission, type), do: %Transmission{transmission | type: type}

  @doc """
  Set the transmission's joints
  """
  @spec joints(Transmission.t(), [Transmission.Joint.t()]) :: Transmission.t()
  def joints(%Transmission{} = transmission, joints) when is_list(joints),
    do: %Transmission{transmission | joints: joints}

  @doc """
  Set the transmission's actuators
  """
  @spec actuators(Transmission.t(), [Transmission.Actuator.t()]) :: Transmission.t()
  def actuators(%Transmission{} = transmission, actuators) when is_list(actuators),
    do: %Transmission{transmission | actuators: actuators}
end
