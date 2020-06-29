defmodule Kinemat.Robot.Colour do
  defstruct r: nil, g: nil, b: nil, a: nil
  alias __MODULE__

  @moduledoc """
  Describes a colour in the robot description.
  """

  @type t :: %Colour{
          r: 0..1,
          g: 0..1,
          b: 0..1,
          a: 0..1
        }

  @doc """
  Initialise a new colour from the provided red, green and blue values.
  """
  @spec init(0..1, 0..1, 0..1) :: Colour.t()
  def init(r, g, b), do: %Colour{r: r, g: g, b: b, a: 1}

  @doc """
  Initialise a new colour from the provided red, green, blue and alpha values.
  """
  @spec init(0..1, 0..1, 0..1, 0..1) :: Colour.t()
  def init(r, g, b, a), do: %Colour{r: r, g: g, b: b, a: a}
end
