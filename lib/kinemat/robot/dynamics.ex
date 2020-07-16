defmodule Kinemat.Robot.Dynamics do
  defstruct damping: nil, friction: nil
  alias Kinemat.Robot.Dynamics

  @moduledoc """
  Encapsulates the dynamics of a joint.
  """

  @type optional_number :: number | nil

  @type t :: %Dynamics{
          damping: optional_number,
          friction: optional_number
        }

  @doc """
  Initialise a new dynamics container with the provided values.
  """
  @spec init(optional_number, optional_number) :: Dynamics.t()
  def init(damping, friction), do: %Dynamics{damping: damping, friction: friction}
end
