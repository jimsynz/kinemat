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

  @doc """
  Initialise a new empty Robot description.
  """
  @spec init(String.t()) :: Kinemat.Robot.t()
  def init(name), do: %Robot{name: name}

  @doc """
  Add a new link to the robot.
  """
  @spec add_link(Robot.t(), Link.t()) :: Robot.t()
  def add_link(%Robot{links: links} = robot, %Link{} = link),
    do: %Robot{robot | links: [link | links]}

  @doc """
  Add a new joint to the robot.
  """
  @spec add_joint(Robot.t(), Joint.t()) :: Robot.t()
  def add_joint(%Robot{joints: joints} = robot, %Joint{} = joint),
    do: %Robot{robot | joints: [joint | joints]}

  @doc """
  Add a new material to the robot.
  """
  @spec add_material(Robot.t(), Material.t()) :: Robot.t()
  def add_material(%Robot{materials: materials} = robot, %Material{} = material),
    do: %Robot{robot | materials: [material | materials]}

  @doc """
  Retrieve a named link from the Robot.
  """
  @spec get_link(Robot.t(), String.t()) :: {:ok, Link.t()} | {:error, any}
  def get_link(%Robot{links: links}, name) do
    case Enum.find(links, fn
           %Link{name: ^name} -> true
           _ -> false
         end) do
      %Link{} = link -> {:ok, link}
      _ -> {:error, "No such link"}
    end
  end

  @doc """
  Retrieve a named joint from the Robot.
  """
  @spec get_joint(Robot.t(), String.t()) :: {:ok, Joint.t()} | {:error, any}
  def get_joint(%Robot{joints: joints}, name) do
    case Enum.find(joints, fn
           %Joint{name: ^name} -> true
           _ -> false
         end) do
      %Joint{} = joint -> {:ok, joint}
      _ -> {:error, "No such joint"}
    end
  end
end
