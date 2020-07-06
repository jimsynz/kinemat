defmodule Kinemat.Robot.Link do
  defstruct name: nil, visual: nil, origin: nil, collision: nil, inertia: nil
  alias Kinemat.{Robot.Collision, Robot.Inertia, Robot.Link, Robot.Visual}

  @moduledoc """
  Defines a solid body in the kinematic chain of a robot.
  """

  @type t :: %Link{
          name: String.t(),
          visual: Visual.t() | nil,
          collision: Collision.t() | nil,
          inertia: Inertia.t() | nil
        }

  @spec init(String.t()) :: Link.t()
  def init(name), do: %Link{name: name}

  @spec visual(Link.t(), Visual.t()) :: Link.t()
  def visual(%Link{} = link, %Visual{} = visual),
    do: %Link{link | visual: visual}

  @spec collision(Link.t(), Collision.t()) :: Link.t()
  def collision(%Link{} = link, %Collision{} = collision),
    do: %Link{link | collision: collision}

  @spec inertia(Link.t(), Inertia.t()) :: Link.t()
  def inertia(%Link{} = link, %Inertia{} = inertia),
    do: %Link{link | inertia: inertia}
end
