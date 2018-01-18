defmodule Kinemat.Coordinates.Cartesian do
  defstruct ~w(x y z)a
  alias __MODULE__

  @moduledoc """
  Describes a point in three-dimensional space using cartesian coordinates (x, y, z).
  """

  @type t :: %Cartesian{x: number, y: number, z: number}

  @doc """
  Initialise a cartesian point from `x`, `y` and `z`.

  ## Examples

      iex> Cartesian.init(3, 4, 5)
      %Kinemat.Coordinates.Cartesian{x: 3, y: 4, z: 5}
  """
  @spec init(number, number, number) :: t
  def init(x, y, z) do
    %Cartesian{x: x, y: y, z: z}
  end

  @doc """
  Return the x component of the point.

  ## Examples

      iex> Cartesian.init(3, 4, 5)
      ...> |> Cartesian.x()
      3
  """
  @spec x(t) :: number
  def x(%Cartesian{x: x}), do: x

  @doc """
  Return the y component of the point.

  ## Examples

      iex> Cartesian.init(3, 4, 5)
      ...> |> Cartesian.y()
      4
  """
  @spec y(t) :: number
  def y(%Cartesian{y: y}), do: y

  @doc """
  Return the z component of the point.

  ## Examples

      iex> Cartesian.init(3, 4, 5)
      ...> |> Cartesian.z()
      5
  """
  @spec z(t) :: number
  def z(%Cartesian{z: z}), do: z
end
