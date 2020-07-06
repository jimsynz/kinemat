defmodule Kinemat.Robot.Collision do
  defstruct geometry: nil, origin: nil
  alias Kinemat.{Robot.Collision, Frame, Robot.Geometric, Geometry, Robot.Orientable}

  @moduledoc """
  A container for the collision properties of a link.
  """

  @type t :: %Collision{
          geometry: Geometry.t() | nil,
          origin: Frame.t() | nil
        }

  @doc """
  Initialise an empty collision container.
  """
  @spec init :: Collision.t()
  def init, do: %Collision{}

  @doc """
  Set the geometry to be stored in the collision container.
  """
  @spec geometry(Collision.t(), Geometry.t()) :: Collision.t()
  def geometry(%Collision{} = collision, geometry),
    do: %Collision{collision | geometry: geometry}

  @doc """
  Set the origin of the collision geometry.
  """
  @spec origin(Collision.t(), Point.t()) :: Collision.t()
  def origin(%Collision{} = collision, origin),
    do: %Collision{collision | origin: origin}

  defimpl Geometric do
    def set(%Collision{} = collision, geometry),
      do: %Collision{collision | geometry: geometry}

    def get(%Collision{geometry: geometry}),
      do: geometry
  end

  defimpl Orientable do
    def set(%Collision{} = collision, %Frame{} = origin),
      do: %Collision{collision | origin: origin}

    def get(%Collision{origin: origin}), do: origin
  end
end
