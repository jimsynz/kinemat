defmodule Kinemat.Geometry.Mesh do
  defstruct filename: nil, scale: 1
  alias Kinemat.Geometry.Mesh

  @moduledoc """
  Describes a mesh geometry.

  Note that kinemat doesn't understand meshes, however it may be required to be
  able to describe them in URDF.
  """

  @type t :: %Mesh{filename: Path.t()}

  @doc """
  Initialise a new mesh from the provided file.
  """
  @spec init(Path.t()) :: Mesh.t()
  def init(filename), do: %Mesh{filename: filename}

  @doc """
  Set the scaling factor for the mesh.
  """
  @spec scale(Mesh.t(), number) :: Mesh.t()
  def scale(%Mesh{} = mesh, scale) when is_number(scale),
    do: %Mesh{mesh | scale: scale}
end
