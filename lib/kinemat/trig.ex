defmodule Kinemat.Trig do
  def sin(%Angle{} = angle) do
    {_, result} = Angle.sin(angle)
    result
  end

  def cos(%Angle{} = angle) do
    {_, result} = Angle.cos(angle)
    result
  end

  def tan(%Angle{} = angle) do
    {_, result} = Angle.tan(angle)
    result
  end
end
