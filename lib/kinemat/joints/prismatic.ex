defmodule Kinemat.Joints.Prismatic do
  alias __MODULE__
  alias Kinemat.{Frame, Joint}
  defstruct [:frame, :limits, :position]

  @moduledoc """
  Describes a [Prismatic](https://en.wikipedia.org/wiki/Prismatic_joint) (AKA Sliding) joint.
  """

  @type t :: %Prismatic{
          frame: Frame.t(),
          limits: nil | Joint.translation_limit(),
          position: number
        }

  @doc """
  Initialize a new prismatic joint from a reference frame.
  """
  @spec init(Frame.t()) :: Prismatic.t()
  def init(%Frame{} = frame) do
    %Prismatic{frame: frame, limits: nil, position: 0}
  end

  @doc """
  Initialize a new prismatic joint from a reference frame with translation limits.
  """
  @spec init(Frame.t(), [{:limits, Joint.translation_limit()}]) :: Prismatic.t()
  def init(%Frame{} = frame, limits: {lower, upper}) when is_number(lower) and is_number(upper) do
    %Prismatic{frame: frame, limits: {lower, upper}, position: lower}
  end
end

defimpl Kinemat.Joint, for: Kinemat.Joints.Prismatic do
  def degrees_of_freedom(_joint), do: 1
end
