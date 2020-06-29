defmodule Kinemat.Robot do
  defstruct name: nil, links: [], joints: [], materials: []
  alias Kinemat.{Robot, Robot.Joint, Robot.Link, Robot.Material}

  @moduledoc """
  A data-structure representing a robot.
  """

  @type t :: %Robot{
          name: String.t(),
          links: [Link.t()],
          joints: [Joint.t()],
          materials: [Material.t()]
        }

  def init(name), do: %Robot{name: name}

  def add_link(%Robot{links: links} = robot, %Link{} = link),
    do: %Robot{robot | links: [link | links]}

  def add_joint(%Robot{joints: joints} = robot, %Joint{} = joint),
    do: %Robot{robot | joints: [joint | joints]}

  def add_material(%Robot{materials: materials} = robot, %Material{} = material),
    do: %Robot{robot | materials: [material | materials]}

  def get_link(%Robot{links: links}, name) do
    case Enum.find(links, fn
           %Link{name: ^name} -> true
           _ -> false
         end) do
      %Link{} = link -> {:ok, link}
      _ -> {:error, "No such link"}
    end
  end
end
