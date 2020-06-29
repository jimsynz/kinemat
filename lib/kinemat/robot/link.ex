defmodule Kinemat.Robot.Link do
  defstruct name: nil, visual: nil, origin: nil
  alias Kinemat.{Robot.Link, Visual}

  @moduledoc """
  Defines a solid body in the kinematic chain of a robot.
  """

  @type t :: %Link{
          name: String.t(),
          visual: Visual.t()
        }

  @spec init(String.t()) :: Link.t()
  def init(name), do: %Link{name: name}

  @spec visual(Link.t(), Visual.t()) :: Link.t()
  def visual(link, visual), do: %{link | visual: visual}
end
