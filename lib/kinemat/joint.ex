defprotocol Kinemat.Joint do
  alias Kinemat.Joints.{Revolute, Prismatic}

  @moduledoc """
  Container module for Kinemat's join representations.

  `use` this module to automatically alias all joint modules.
  """

  @type t :: Revolute.t() | Prismatic.t()
  @type rotation_limit :: {lower :: Angle.t(), upper :: Angle.t()}
  @type translation_limit :: {lower :: number, upper :: number}

  @doc """
  Returns the number of degrees of freedom of this joint.

  ## Examples

      iex> Cartesian.init(0, 0, 0)
      ...> |> Frame.init(Euler.init(:xyz, ~a(0), ~a(0), ~a(0)))
      ...> |> Revolute.init()
      ...> |> Joint.degrees_of_freedom()
      1
  """
  @spec degrees_of_freedom(t()) :: non_neg_integer
  def degrees_of_freedom(_joint)
end
