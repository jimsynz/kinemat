defmodule Kinemat.Frame do
  use Kinemat
  use Kinemat.Coordinates
  use Kinemat.Orientations
  defstruct ~w(point orientation)a

  @moduledoc """
  Describes the position of a coordinate frame with reference to it's
  parent reference frame.
  """

  @type t :: %Frame{point: Point.t(), orientation: Orientation.t()}

  @doc """
  Initialise a frame from a point and an orientation.
  """
  @spec init(Point.t(), Orientation.t()) :: t
  def init(%{__struct__: p} = point, %{__struct__: o} = orientation)
      when (p == Cartesian or p == Cylindrical or p == Spherical) and
             (o == Euler or o == Quaternion or o == RotationMatrix) do
    %Frame{point: point, orientation: orientation}
  end

  @doc """
  Returns the coordinate (translation) portion of the frame.

  ## Examples

      iex> Frame.init(Cartesian.init(3,4,5), Euler.init(:xyz, ~a(0), ~a(0), ~a(0)))
      ...> |> Frame.point()
      #Kinemat.Point<[x: 3, y: 4, z: 5]>
  """
  @spec point(t) :: Point.t()
  def point(%Frame{point: p}), do: p

  @doc """
  Returns the orientation portion of the frame.

  ## Examples

      iex> Frame.init(Cartesian.init(3,4,5), Euler.init(:xyz, ~a(0), ~a(0), ~a(0)))
      ...> |> Frame.orientation()
      #Kinemat.Orientation<[euler: :xyz, x: #Angle<0>, y: #Angle<0>, z: #Angle<0>]>
  """
  @spec orientation(t) :: Orientation.t()
  def orientation(%Frame{orientation: o}), do: o
end
