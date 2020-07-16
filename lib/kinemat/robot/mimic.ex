defmodule Kinemat.Robot.Mimic do
  defstruct joint_name: nil, multiplier: nil, offset: nil
  alias Kinemat.Robot.Mimic

  @moduledoc """
  Encapsulates a joint mimicry.
  """

  @type optional_number :: number | nil

  @type t :: %Mimic{
          joint_name: String.t() | nil,
          multiplier: optional_number,
          offset: optional_number
        }

  @doc """
  Initialise a new mimic container with the provided values.
  """
  @spec init(String.t(), optional_number, optional_number) :: Mimic.t()
  def init(joint_name, multiplier, offset),
    do: %Mimic{joint_name: joint_name, multiplier: multiplier, offset: offset}
end
