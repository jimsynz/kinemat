defmodule Kinemat.Robot.Calibration do
  defstruct rising: nil, falling: nil
  alias Kinemat.Robot.Calibration

  @moduledoc """
  Encapsulates the calibration of a joint.
  """

  @type optional_number :: number | nil

  @type t :: %Calibration{
          rising: optional_number,
          falling: optional_number
        }

  @doc """
  Initialise a new calibration container with the provided values.
  """
  @spec init(optional_number, optional_number) :: Calibration.t()
  def init(rising, falling), do: %Calibration{rising: rising, falling: falling}
end
