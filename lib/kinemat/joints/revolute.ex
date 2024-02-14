defmodule Kinemat.Joints.Revolute do
  alias __MODULE__
  alias Kinemat.{Frame, Joint}
  use Angle
  defstruct [:frame, :limits, :position]

  @moduledoc """
  Describes a [Revolute](https://en.wikipedia.org/wiki/Revolute_joint) (AKA Hinged) joint.
  """

  @type t :: %Revolute{
          frame: Frame.t(),
          limits: nil | Joint.rotation_limit(),
          position: Angle.t()
        }

  @doc """
  Initialize a new revolute joint from a reference frame.
  """
  @spec init(Frame.t()) :: Revolute.t()
  def init(%Frame{} = frame) do
    %Revolute{frame: frame, limits: nil, position: ~a(0)}
  end

  @doc """
  Initialize a new revolute joint from a reference frame including rotation limits.
  """
  @spec init(Frame.t(), [{:limits, Joint.rotation_limit()}]) :: Revolute.t()
  def init(%Frame{} = frame, limits: {%Angle{} = lower, %Angle{} = upper}) do
    %Revolute{frame: frame, limits: {lower, upper}, position: lower}
  end
end

defimpl Kinemat.Joint, for: Kinemat.Joints.Revolute do
  def degrees_of_freedom(_joint), do: 1
end
