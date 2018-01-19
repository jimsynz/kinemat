defmodule Kinemat.Orientations.Euler do
  alias __MODULE__
  defstruct ~w(representation x y z)a

  @moduledoc """
  Describes a 3 dimension orientation using Euler angles.

  This module can handle the following representations; XYZ, YXZ, ZXY, ZYX,
  YZX, ZXY.
  """
  @type valid_representation :: :xyz | :yxz | :zxy | :zyx | :yzx | :xzy
  @type t :: %Euler{
          representation: valid_representation,
          x: Angle.t(),
          y: Angle.t(),
          z: Angle.t()
        }

  @doc """
  Initialise a new Euler orientation with angles.

  * `representation`: The axis-order of this rotation.
  * `x`: The X axis rotation.
  * `y`: The Y axis rotation.
  * `z`: The Z axis rotation.

  ## Examples:

      iex> Euler.init(:xyz, ~a(10)d, ~a(20)d, ~a(30)d)
      %Euler{representation: :xyz,
             x: ~a(10)d,
             y: ~a(20)d,
             z: ~a(30)d}
  """
  @spec init(valid_representation, Angle.t(), Angle.t(), Angle.t()) :: t
  def init(representation, %Angle{} = x, %Angle{} = y, %Angle{} = z)
      when representation in ~w(xyz yxz zxy zyx yzx xzy)a do
    %Euler{representation: representation, x: x, y: y, z: z}
  end

  @doc """
  Returns the representation of the Euler.

  ## Examples

      iex> Euler.init(:zyx, ~a(0), ~a(0), ~a(0))
      ...> |> Euler.order()
      :zyx
  """
  @spec representation(t) :: valid_representation
  def representation(%Euler{representation: r}), do: r

  @doc """
  Alias for `representation`.
  """
  @spec order(t) :: valid_representation
  def order(euler), do: representation(euler)

  @doc """
  Returns the θ of rotation around the X axis.

  ## Examples

      iex> Euler.init(:xyz, ~a(13)d, ~a(0), ~a(0))
      ...> |> Euler.x
      #Angle<13°>
  """
  @spec x(t) :: Angle.t()
  def x(%Euler{x: x}), do: x

  @doc """
  Returns the θ of rotation around the Y axis.

  ## Examples

      iex> Euler.init(:xyz, ~a(0), ~a(13)d, ~a(0))
      ...> |> Euler.y
      #Angle<13°>
  """
  @spec y(t) :: Angle.t()
  def y(%Euler{y: y}), do: y

  @doc """
  Returns the θ of rotation around the Z axis.

  ## Examples

      iex> Euler.init(:xyz, ~a(0), ~a(0), ~a(13)d)
      ...> |> Euler.z
      #Angle<13°>
  """
  @spec z(t) :: Angle.t()
  def z(%Euler{z: z}), do: z
end
