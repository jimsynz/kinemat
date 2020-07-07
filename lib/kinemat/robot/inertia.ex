defmodule Kinemat.Robot.Inertia do
  defstruct origin: nil, mass: nil, matrix: nil
  alias Kinemat.{Frame, Orientations.RotationMatrix, Robot.Inertia, Robot.Orientable}

  @moduledoc """
  A container for the inertial properties of a link.
  """

  @type t :: %Inertia{
          origin: Frame.t() | nil,
          mass: number | nil,
          matrix: RotationMatrix | nil
        }

  @doc """
  Initialise empty inertia container..
  """
  @spec init :: Inertia.t()
  def init, do: %Inertia{}

  @doc """
  Set the mass component of the inertial container.
  """
  @spec mass(Inertia.t(), number) :: Inertia.t()
  def mass(%Inertia{} = inertia, mass) when is_number(mass),
    do: %Inertia{inertia | mass: mass}

  @doc """
  Set the matrix of the inertial container.
  """
  @spec matrix(Inertia.t(), RotationMatrix.t()) :: Inertia.t()
  def matrix(%Inertia{} = inertia, %RotationMatrix{} = matrix),
    do: %Inertia{inertia | matrix: matrix}

  defimpl Orientable do
    def set(%Inertia{} = inertia, %Frame{} = frame),
      do: %Inertia{inertia | origin: frame}

    def get(%Inertia{origin: origin}), do: origin
  end
end
