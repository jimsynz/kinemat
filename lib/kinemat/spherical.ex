defmodule Kinemat.Spherical do
  alias Kinemat.Spherical
  defstruct ~w(radial azimuth polar)a

  @moduledoc """
  Describes a point in 3D space using sperical notation (r,θ,ɸ).
  """

  @type t :: %Spherical{radial:  number,
                        azimuth: Angle.t,
                        polar:   Angle.t}

  @doc """
  Initialise a sperical coordinate point from `rho`, `theta` and `phi` (r,θ,ɸ).

  ## Examples

      iex> Spherical.init(10, Degrees.init(20), Degrees.init(30))
      %Kinemat.Spherical{radial:  10,
                         azimuth: ~a(20)d,
                         polar:   ~a(30)d}
  """
  @spec init(number, Angle.t, Angle.t) :: t
  def init(rho, %Angle{} = theta, %Angle{} = phi) do
    %Spherical{radial: rho, azimuth: theta, polar: phi}
  end

  @doc """
  Alias for `radial/1`.
  """
  @spec rho(t) :: number
  def rho(point), do: point |> radial()

  @doc """
  Return the radial component of the point.

  ## Examples

      iex> Spherical.init(10, ~a(20)d, ~a(30)d)
      ...> |> Spherical.radial()
      10
  """
  @spec radial(t) :: number
  def radial(%Spherical{radial: rho}), do: rho

  @doc """
  Alias for `azimuth/1`.
  """
  @spec theta(t) :: Angle.t
  def theta(point), do: point |> azimuth()

  @doc """
  Return the azimuthal component of the point.

  ## Examples

      iex> Spherical.init(10, ~a(20)d, ~a(30)d)
      ...> |> Spherical.azimuth
      ~a(20)d
"""
  @spec azimuth(t) :: Angle.t
  def azimuth(%Spherical{azimuth: theta}), do: theta

  @doc """
  Alias for `polar/1`.
  """
  @spec phi(t) :: Angle.t
  def phi(point), do: point |> polar()

  @doc """
  Return the polar component of the point.

  ## Examples

      iex> Spherical.init(10, ~a(20)d, ~a(30)d)
      ...> |> Spherical.polar
      ~a(30)d
  """
  @spec polar(t) :: Angle.t
  def polar(%Spherical{polar: phi}), do: phi
end
