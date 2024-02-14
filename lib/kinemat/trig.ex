defmodule Kinemat.Trig do
  @moduledoc """
  A simple wrapper around `Angle`'s trig functions for compatibility.
  """

  @doc false
  @spec sin(Angle.t()) :: number
  def sin(%Angle{} = angle) do
    {_, result} = Angle.sin(angle)
    result
  end

  @doc false
  @spec cos(Angle.t()) :: number
  def cos(%Angle{} = angle) do
    {_, result} = Angle.cos(angle)
    result
  end

  @doc false
  @spec tan(Angle.t()) :: number
  def tan(%Angle{} = angle) do
    {_, result} = Angle.tan(angle)
    result
  end
end
