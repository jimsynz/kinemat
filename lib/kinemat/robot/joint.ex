defmodule Kinemat.Robot.Joint do
  defstruct name: nil,
            type: nil,
            parent_name: nil,
            child_name: nil,
            origin: nil,
            axis: nil,
            limit: nil,
            calibration: nil,
            dynamics: nil,
            mimic: nil,
            safety_controller: nil

  alias Kinemat.{
    Frame,
    Orientation,
    Robot.Calibration,
    Robot.Dynamics,
    Robot.Joint,
    Robot.Limit,
    Robot.Mimic,
    Robot.Orientable,
    Robot.SafetyController
  }

  @moduledoc """
  Represents a joint in a Robot body.
  """

  @type joint_type :: :revolute | :continuous | :prismatic | :fixed | :floating | :planar

  @type t :: %Joint{
          name: String.t(),
          type: joint_type | nil,
          parent_name: String.t() | nil,
          child_name: String.t() | nil,
          origin: Frame.t() | nil,
          axis: Orientation.t() | nil,
          limit: Limit.t() | nil,
          calibration: Calibration.t() | nil,
          dynamics: Dynamics.t() | nil,
          mimic: Mimic.t() | nil,
          safety_controller: SafetyController.t() | nil
        }

  @doc """
  Initialise a new joint.
  """
  @spec init(String.t(), String.t()) :: Joint.t()
  def init(name, "revolute"), do: %Joint{name: name, type: :revolute}
  def init(name, "continuous"), do: %Joint{name: name, type: :continuous}
  def init(name, "prismatic"), do: %Joint{name: name, type: :prismatic}
  def init(name, "fixed"), do: %Joint{name: name, type: :fixed}
  def init(name, "floating"), do: %Joint{name: name, type: :floating}
  def init(name, "planar"), do: %Joint{name: name, type: :planar}

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
  @spec axis(Joint.t(), Orientation.t()) :: Joint.t()
  def axis(%Joint{} = joint, frame), do: %Joint{joint | axis: frame}

  @doc """
  Set the safety limits of the joint.
  """
  @spec limit(Joint.t(), Limit.t()) :: Joint.t()
  def limit(%Joint{} = joint, %Limit{} = limit), do: %Joint{joint | limit: limit}

  @doc """
  Set the calibration of the joint.
  """
  @spec calibration(Joint.t(), Calibration.t()) :: Joint.t()
  def calibration(%Joint{} = joint, %Calibration{} = calibration),
    do: %Joint{joint | calibration: calibration}

  @doc """
  Set the dynamics of the joint.
  """
  @spec dynamics(Joint.t(), Dynamics.t()) :: Joint.t()
  def dynamics(%Joint{} = joint, %Dynamics{} = dynamics),
    do: %Joint{joint | dynamics: dynamics}

  @doc """
  Make the joint mimic another joint.
  """
  @spec mimic(Joint.t(), Mimic.t()) :: Joint.t()
  def mimic(%Joint{} = joint, %Mimic{} = mimic),
    do: %Joint{joint | mimic: mimic}

  @doc """
  Add a safety controller to the joint.
  """
  @spec safety_controller(Joint.t(), SafetyController.t()) :: Joint.t()
  def safety_controller(%Joint{} = joint, %SafetyController{} = safety_controller),
    do: %Joint{joint | safety_controller: safety_controller}

  defimpl Orientable do
    import Angle.Sigil
    alias Kinemat.{Coordinates.Cartesian, Frame, Orientations.Euler}

    def set(%Joint{} = joint, %Frame{} = frame),
      do: %Joint{joint | origin: frame}

    def get(%Joint{origin: nil}),
      do: Frame.init(Cartesian.init(0, 0, 0), Euler.init(:xyz, ~a(0), ~a(0), ~a(0)))

    def get(%Joint{origin: origin}), do: origin
  end
end
