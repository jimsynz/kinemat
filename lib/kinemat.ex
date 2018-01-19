defmodule Kinemat do
  defmacro __using__(_opts) do
    quote do
      alias Kinemat.{
        Point,
        Orientation,
        Frame
      }

      import Angle.Sigil
      # import Kinemat.Sigil
    end
  end

  @moduledoc """
  Kinemat handles forward, reverse and dynamics kinematics for robotic systems
  and 3D simulation.

  Use this module to automatically include a bunch of aliases and helpers.

  ## Examples

      iex> use Kinemat
      ...> use Kinemat.Orientations
      ...> Euler.init(:xyz, ~a(0), ~a(0), ~a(0))
      #Kinemat.Orientation<[euler: :xyz, x: #Angle<0>, y: #Angle<0>, z: #Angle<0>]>
  """
end
