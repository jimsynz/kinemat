defmodule Kinemat.Quaternion do
  alias Kinemat.Quaternion
  defstruct ~w(w x y z)a

  @moduledoc """
  Describes an orientation using Quaternions.
  """

  @type t :: %Quaternion{w: Angle.t(), x: number, y: number, z: number}

  @doc """
  Create a Quaternion using `w`, `x`, `y` and `z` where
  `w` is the angle and `x`, `y` and `z` are the axis coordinates.

  ## Examples

      Initialising with an Angle.

      iex> Quaternion.init(~a(90)d, 10, 20, 30)
      %Kinemat.Quaternion{w: ~a(90)d, x: 10, y: 20, z: 30}
  """
  @spec init(Angle.t(), number, number, number) :: t
  def init(%Angle{} = w, x, y, z), do: %Quaternion{w: w, x: x, y: y, z: z}

  @doc """
  Returns the `w` component of the Quaternion.
  """
  @spec w(t) :: Angle.t()
  def w(%Quaternion{w: w}), do: w

  @doc """
  Returns the `x` component (or the i multiplier) of the Quaternion.
  """
  @spec x(t) :: number
  def x(%Quaternion{x: x}), do: x

  @doc """
  Returns the `y` component (or the j multiplier) of the Quaternion.
  """
  @spec y(t) :: number
  def y(%Quaternion{y: y}), do: y

  @doc """
  Returns the `z` component (or the k multiplier) of the Quaternion.
  """
  @spec z(t) :: number
  def z(%Quaternion{z: z}), do: z
end
