defmodule Kinemat.Robot.Joint do
  defstruct name: nil,
            type: nil,
            parent_name: nil,
            child_name: nil,
            origin: nil,
            axis: nil,
            limit: nil

  alias Kinemat.{Frame, Robot.Joint, Robot.Limit, Robot.Orientable}

  @moduledoc """
  Represents a joint in a Robot body.
  """

  @type t :: %Joint{
          name: String.t(),
          type: String.t(),
          parent_name: String.t() | nil,
          child_name: String.t() | nil,
          origin: Frame | nil,
          axis: Frame | nil,
          limit: Limit | nil
        }

  @doc """
  Initialise a new joint.
  """
  @spec init(String.t(), String.t()) :: Joint.t()
  def init(name, type), do: %Joint{name: name, type: type}

  @doc """
  Set the name of the parent link.
  """
  @spec parent_name(Joint.t(), String.t()) :: Joint.t()
  def parent_name(%Joint{} = joint, name), do: %Joint{joint | parent_name: name}

  @doc """
  Set the name of the child link.
  """
  @spec child_name(Joint.t(), String.t()) :: Joint.t()
  def child_name(%Joint{} = joint, name), do: %Joint{joint | child_name: name}

  @doc """
  Set the reference frame of the joint axis.
  """
  @spec axis(Joint.t(), Frame.t()) :: Joint.t()
  def axis(%Joint{} = joint, frame), do: %Joint{joint | axis: frame}

  @doc """
  Set the safety limits of the joint.
  """
  @spec limit(Joint.t(), Limit.t()) :: Joint.t()
  def limit(%Joint{} = joint, %Limit{} = limit), do: %Joint{joint | limit: limit}

  defimpl Orientable do
    def set(%Joint{} = joint, %Frame{} = frame),
      do: %Joint{joint | origin: frame}

    def get(%Joint{origin: origin}), do: origin
  end
end
