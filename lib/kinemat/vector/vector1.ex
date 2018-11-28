defmodule Kinemat.Vector.Vector1 do
  alias __MODULE__
  defstruct x: 0

  @type t :: %Vector1{x: float}

  @moduledoc """
  A 1-dimensional vector.
  """

  @doc """
  Creates a `Vector1` initialized with a numeric value.

  ## Example

      iex> Vector1.init(1.21)
      %Vector1{x: 1.21}
  """
  @spec init(number) :: Vector1.t()
  def init(x), do: %Vector1{x: x}

  @doc """
  Creates a `Vector1` initialized with a zero value.

  ## Example

      iex> Vector1.zero()
      %Vector1{x: 0}
  """
  @spec zero() :: Vector1.t()
  def zero, do: init(0)

  @doc """
  Unit vector in the `x` direction.

  ## Example

      iex> Vector1.unit_x()
      %Vector1{x: 1.0}
  """
  @spec unit_x() :: Vector1.t()
  def unit_x, do: init(1.0)
end
