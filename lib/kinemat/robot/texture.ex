defmodule Kinemat.Robot.Texture do
  defstruct filename: nil
  alias Kinemat.Robot.Texture

  @moduledoc """
  A texture to apply to a material.
  """

  @type t :: %Texture{filename: Path.t() | nil}

  @doc """
  Create a new texture with the provided filename.
  """
  @spec init(Path.t()) :: Material.t()
  def init(filename), do: %Texture{filename: filename}
end
