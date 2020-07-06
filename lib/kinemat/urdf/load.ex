defmodule Kinemat.URDF.Load do
  alias Kinemat.{Coordinates, Frame, Geometry, Orientations, Robot}
  import Kinemat.URDF.XmlHelpers

  @moduledoc """
  This module implements the ability to parse a URDF file using the `:xmerl` OTP
  library.
  """

  @doc """
  Attempt to load and parse a URDF XML file.
  """
  @spec load(Path.t()) :: {:ok, Robot.t()} | {:error, any}
  def load(path) do
    with {node, []} <- :xmerl_scan.file(path), do: parse(node, nil)
  end

  defp parse(node, state) when is_element(node) do
    with {:ok, name} <- get_name(node), do: parse(name, node, state)
  end

  defp parse(node, state) when is_text(node), do: {:ok, state}

  defp parse(:robot, node, nil) when is_element(node) do
    with {:ok, name} <- get_attribute_value(node, :name),
         robot <- Robot.init(name),
         {:ok, children} <- get_children(node) do
      Enum.reduce_while(children, {:ok, robot}, fn node, {:ok, robot} ->
        case parse(node, robot) do
          {:ok, robot} -> {:cont, {:ok, robot}}
          {:error, reason} -> {:halt, {:error, reason}}
        end
      end)
    end
  end

  defp parse(:link, node, %Robot{} = robot) do
    with {:ok, name} <- get_attribute_value(node, :name),
         link <- Robot.Link.init(name),
         {:ok, children} <- get_children(node),
         {:ok, link} <- reduce_oks(children, link, &parse(&1, &2)),
         do: {:ok, Robot.add_link(robot, link)}
  end

  defp parse(:joint, node, %Robot{} = robot) do
    with {:ok, name} <- get_attribute_value(node, :name),
         {:ok, type} <- get_attribute_value(node, :type),
         joint <- Robot.Joint.init(name, type),
         {:ok, children} <- get_children(node),
         {:ok, joint} <- reduce_oks(children, joint, &parse(&1, &2)),
         do: {:ok, Robot.add_joint(robot, joint)}
  end

  defp parse(:material, node, %Robot{} = robot) do
    with {:ok, name} <- get_attribute_value(node, :name),
         material <- Robot.Material.init(name),
         {:ok, children} <- get_children(node),
         {:ok, material} <- reduce_oks(children, material, &parse(&1, &2)),
         do: {:ok, Robot.add_material(robot, material)}
  end

  defp parse(:color, node, %Robot.Material{} = material) do
    [r, g, b, a] = extract_floats(node, :rgba, [0, 0, 0, 0])
    {:ok, Robot.Material.colour(material, Robot.Colour.init(r, g, b, a))}
  end

  defp parse(:parent, node, %Robot.Joint{} = joint) do
    with {:ok, name} <- get_attribute_value(node, :link),
         do: {:ok, Robot.Joint.parent_name(joint, name)}
  end

  defp parse(:child, node, %Robot.Joint{} = joint) do
    with {:ok, name} <- get_attribute_value(node, :link),
         do: {:ok, Robot.Joint.child_name(joint, name)}
  end

  defp parse(:visual, node, %Robot.Link{} = link) do
    with {:ok, children} <- get_children(node),
         visual <- Robot.Visual.init(),
         {:ok, visual} <- reduce_oks(children, visual, &parse(&1, &2)),
         do: {:ok, Robot.Link.visual(link, visual)}
  end

  defp parse(:geometry, node, geometric) do
    with {:ok, children} <- get_children(node),
         {:ok, geometric} <- reduce_oks(children, geometric, &parse(&1, &2)),
         do: {:ok, geometric}
  end

  defp parse(:cylinder, node, geometric) do
    with [length] <- extract_floats(node, :length, [0]),
         [radius] <- extract_floats(node, :radius, [0]),
         cylinder <- Geometry.Cylinder.init(length, radius),
         do: {:ok, Robot.Geometric.set(geometric, cylinder)}
  end

  defp parse(:box, node, geometric) do
    with [x, y, z] <- extract_floats(node, :size, [0, 0, 0]),
         box <- Geometry.Box.init(x, y, z),
         do: {:ok, Robot.Geometric.set(geometric, box)}
  end

  defp parse(:sphere, node, geometric) do
    with [radius] <- extract_floats(node, :radius, [0]),
         sphere <- Geometry.Sphere.init(radius),
         do: {:ok, Robot.Geometric.set(geometric, sphere)}
  end

  defp parse(:material, node, %Robot.Visual{} = visual) do
    with {:ok, name} <- get_attribute_value(node, :name),
         do: {:ok, Robot.Visual.material_name(visual, name)}
  end

  defp parse(:origin, node, orientable) do
    [roll, pitch, yaw] =
      node
      |> extract_floats(:rpy, [0, 0, 0])
      |> Enum.map(&Angle.Radian.init(&1))

    [x, y, z] = extract_floats(node, :xyz, [0, 0, 0])

    orientation = Orientations.Euler.init(:xyz, roll, pitch, yaw)
    translation = Coordinates.Cartesian.init(x, y, z)
    frame = Frame.init(translation, orientation)

    {:ok, Robot.Orientable.set(orientable, frame)}
  end

  defp parse(:mesh, node, geometric) do
    with {:ok, filename} <- get_attribute_value(node, :filename),
         mesh <- Geometry.Mesh.init(filename),
         do: {:ok, Robot.Geometric.set(geometric, mesh)}
  end

  defp parse(:axis, node, %Robot.Joint{} = joint) do
    [roll, pitch, yaw] =
      node
      |> extract_floats(:rpy, [0, 0, 0])
      |> Enum.map(&Angle.Radian.init(&1))

    [x, y, z] = extract_floats(node, :xyz, [0, 0, 0])

    orientation = Orientations.Euler.init(:xyz, roll, pitch, yaw)
    translation = Coordinates.Cartesian.init(x, y, z)
    frame = Frame.init(translation, orientation)
    {:ok, Robot.Joint.axis(joint, frame)}
  end

  defp parse(:limit, node, %Robot.Joint{} = joint) do
    [effort] = extract_floats(node, :effort, [0])
    [lower] = extract_floats(node, :lower, [0])
    [upper] = extract_floats(node, :upper, [0])
    [velocity] = extract_floats(node, :velocity, [0])

    limit = Robot.Limit.init(effort: effort, lower: lower, upper: upper, velocity: velocity)
    {:ok, Robot.Joint.limit(joint, limit)}
  end

  defp parse(:collision, node, %Robot.Link{} = link) do
    with {:ok, children} <- get_children(node),
         collision <- Robot.Collision.init(),
         {:ok, collision} <- reduce_oks(children, collision, &parse(&1, &2)),
         do: {:ok, Robot.Link.collision(link, collision)}
  end

  defp parse(:inertial, node, %Robot.Link{} = link) do
    with inertia <- Robot.Inertia.init(),
         {:ok, children} <- get_children(node),
         {:ok, inertia} <- reduce_oks(children, inertia, &parse(&1, &2)),
         do: {:ok, Robot.Link.inertia(link, inertia)}
  end

  defp parse(:mass, node, %Robot.Inertia{} = inertia) do
    [mass] = extract_floats(node, :value, [0])
    {:ok, Robot.Inertia.mass(inertia, mass)}
  end

  defp parse(:inertia, node, %Robot.Inertia{} = inertia) do
    [ixx] = extract_floats(node, :ixx, [0])
    [ixy] = extract_floats(node, :ixy, [0])
    [ixz] = extract_floats(node, :ixz, [0])
    [iyy] = extract_floats(node, :iyy, [0])
    [iyz] = extract_floats(node, :iyz, [0])
    [izz] = extract_floats(node, :izz, [0])

    matrix = Orientations.RotationMatrix.init({ixx, ixy, ixz, ixy, iyy, iyz, ixz, iyz, izz})
    {:ok, Robot.Inertia.matrix(inertia, matrix)}
  end

  defp extract_floats(node, attribute_name, default_value) do
    with {:ok, string} <- get_attribute_value(node, attribute_name),
         string_values <- String.split(string, ~r/\s+/),
         float_values <-
           string_values
           |> Enum.filter(&(byte_size(&1) > 0))
           |> Enum.map(&elem(Float.parse(&1), 0)) do
      float_values
    else
      _ -> default_value
    end
  end
end
