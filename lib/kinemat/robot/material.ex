defmodule Kinemat.Robot.Material do
  defstruct name: nil, colour: nil, texture: nil
  alias Kinemat.Robot.{Colour, Material, Texture}

  @moduledoc """
  A material used in the Robot description.
  """

  @type t :: %Material{
          name: String.t(),
          colour: Colour.t() | nil,
          texture: Texture.t() | nil
        }

  @doc """
  Create a new material with the provided name.
  """
  @spec init(String.t()) :: Material.t()
  def init(name), do: %Material{name: name}

  @doc """
  Set the colour of the material.
  """
  @spec colour(Material.t(), Colour.t()) :: Material.t()
  def colour(%Material{} = material, %Colour{} = colour), do: %Material{material | colour: colour}

  @doc """
  Set the texture of the material.
  """
  @spec texture(Material.t(), Texture.t()) :: Material.t()
  def texture(%Material{} = material, %Texture{} = texture),
    do: %Material{material | texture: texture}
end
