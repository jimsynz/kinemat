defmodule Kinemat.Robot.SafetyController do
  defstruct k_velocity: nil, k_position: nil, soft_upper_limit: nil, soft_lower_limit: nil
  alias Kinemat.Robot.SafetyController

  @moduledoc """
  Encapsulates the safety controller of a joint.
  """

  @type optional_number :: number | nil

  @type t :: %SafetyController{
          k_velocity: optional_number,
          k_position: optional_number,
          soft_upper_limit: optional_number,
          soft_lower_limit: optional_number
        }

  @doc """
  Initialise a new safety controller container with the provided values.
  """
  @spec init(number, optional_number, optional_number, optional_number) :: SafetyController.t()
  def init(k_velocity, k_position, soft_lower_limit, soft_upper_limit),
    do: %SafetyController{
      k_velocity: k_velocity,
      k_position: k_position,
      soft_lower_limit: soft_lower_limit,
      soft_upper_limit: soft_upper_limit
    }
end
