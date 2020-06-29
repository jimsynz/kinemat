defmodule Kinemat.Robot.Joint do
  defstruct name: nil, type: nil, parent_name: nil, child_name: nil, origin: nil
  alias Kinemat.{Frame, Robot.Joint}

  @moduledoc """
  Represents a join in a Robot body.
  """

  @type t :: %Joint{
          name: String.t(),
          type: String.t(),
          parent_name: String.t(),
          child_name: String.t(),
          origin: Frame
        }

  def init(name, type), do: %Joint{name: name, type: type}

  def origin(joint, frame), do: %Joint{joint | origin: frame}
end
