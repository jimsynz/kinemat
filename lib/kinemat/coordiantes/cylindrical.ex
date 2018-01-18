defmodule Kinemat.Coordinates.Cylindrical do
  defstruct ~w(radial azimuth vertical)a
  use Kinemat.Coordinates
  alias __MODULE__

  @moduledoc """
  Describes a point in cylindrical coordinates.
  """

  @type t :: %Cylindrical{radial: number, azimuth: Angle.t(), vertical: number}

  @doc """
  Initalise a cylindrical coordinate from `rho`, `theta`, `z` (ρ,θ,z).

  ## Examples

      iex> Cylindrical.init(10, ~a(20)d, 30)
      %Cylindrical{radial:   10,
                   azimuth:  ~a(20)d,
                   vertical: 30}

      iex> Cylindrical.init(10, ~a(0.5)r, 30)
      %Cylindrical{radial:   10,
                   azimuth:  ~a(0.5)r,
                   vertical: 30}
  """
  @spec init(number, Angle.t(), number) :: t
  def init(rho, %Angle{} = theta, z) do
    %Cylindrical{radial: rho, azimuth: theta, vertical: z}
  end

  @doc """
  Alias for `radial/1`.
  """
  @spec rho(t) :: number
  def rho(point), do: point |> azimuth()

  @doc """
  Return the radial (ρ) component of the point.

  ## Examples

      iex> Cylindrical.init(10, ~a(0.5)r, 30)
      ...> |> Cylindrical.radial()
      10
  """
  @spec radial(t) :: number
  def radial(%Cylindrical{radial: rho}), do: rho

  @doc """
  Alias for `azimuth/1`.
  """
  @spec theta(t) :: Angle.t()
  def theta(point), do: point |> azimuth()

  @doc """
  Return the azimuthal (θ) component of the point.

  ## Examples

      iex> Cylindrical.init(10, ~a(0.5)r, 30)
      ...> |> Cylindrical.azimuth()
      #Angle<0.5㎭>
  """
  @spec azimuth(t) :: Angle.t()
  def azimuth(%Cylindrical{azimuth: theta}), do: theta

  @doc """
  Alias for `vertical/1`.
  """
  @spec z(t) :: number
  def z(point), do: point |> vertical()

  @doc """
  Return the vertical (z) component of the point.

  ## Examples

      iex> Cylindrical.init(10, ~a(0.5)r, 30)
      ...> |> Cylindrical.vertical()
      30
  """
  @spec vertical(t) :: number
  def vertical(%Cylindrical{vertical: z}), do: z
end
