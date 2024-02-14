defmodule Kinemat.Joints.Cylindrical do
  alias __MODULE__
  alias Kinemat.{Frame, Joint}
  use Angle

  defstruct [
    :frame,
    :rotation_limits,
    :translation_limits,
    :current_rotation,
    :current_translation
  ]

  @moduledoc """
  Describes a [Cylindrical joint](https://en.wikipedia.org/wiki/Cylindrical_joint).
  """

  @type t :: %Cylindrical{
          frame: Frame.t(),
          rotation_limits: nil | Joint.rotation_limit(),
          translation_limits: nil | Joint.translation_limit(),
          current_rotation: Angle.t(),
          current_translation: number
        }

  @doc """
  Initialize a new cylindrical joint from a reference frame.
  """
  @spec init(Frame.t()) :: Cylindrical.t()
  def init(%Frame{} = frame) do
    %Cylindrical{
      frame: frame,
      rotation_limits: nil,
      translation_limits: nil,
      current_rotation: ~a(0),
      current_translation: 0
    }
  end

  @doc """
  Initailize a new cylindrical joint from a reference frame including limits.
  """
  @spec init(Frame.t(), [
          {:rotation_limits, Joint.rotation_limit()},
          {:translation_limits, Joint.translation_limit()}
        ]) :: Cylindrical.t()
  def init(%Frame{} = frame, []), do: init(frame)

  def init(%Frame{} = frame, options) when is_list(options) do
    rlimits = Keyword.get(options, :rotation_limits)
    tlimits = Keyword.get(options, :translation_limits)

    crot =
      case rlimits do
        {%Angle{} = lower, %Angle{} = _upper} -> lower
        nil -> ~a(0)
      end

    ctrans =
      case tlimits do
        {lower, upper} when is_number(lower) and is_number(upper) -> lower
        nil -> 0
      end

    %Cylindrical{
      frame: frame,
      rotation_limits: rlimits,
      translation_limits: tlimits,
      current_rotation: crot,
      current_translation: ctrans
    }
  end
end

defimpl Kinemat.Joint, for: Kinemat.Joints.Cylindrical do
  def degrees_of_freedom(_joint), do: 2
end
