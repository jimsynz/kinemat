defmodule Kinemat.URDF do
  @moduledoc """
  Provides the ability to load and save robot descriptions in the ROS-compatible
  URDF XML format.
  """

  alias Kinemat.{Robot, URDF.Load, URDF.Save}

  @doc """
  Loads an URDF XML file and returns a robot description.
  """
  @spec load(Path.t()) :: {:ok, Robot.t()} | {:error, any}
  def load(path), do: Load.load(path)

  @doc """
  Saves a robot description as an URDF XML file.
  """
  @spec save(Robot.t(), Path.t()) :: :ok | {:error, any}
  def save(robot, path), do: Save.save(robot, path)
end
