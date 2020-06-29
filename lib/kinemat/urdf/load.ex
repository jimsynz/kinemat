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
         {:ok, link} <-
           Enum.reduce_while(children, link, fn node, link ->
             case parse(node, link) do
               {:ok, link} -> {:cont, {:ok, link}}
               {:error, reason} -> {:halt, {:error, reason}}
             end
           end) do
      {:ok, Robot.add_link(robot, link)}
    end
  end

  defp parse(:joint, node, %Robot{} = robot) do
    with {:ok, name} <- get_attribute_value(node, :name),
         {:ok, type} <- get_attribute_value(node, :type),
         joint <- Robot.Joint.init(name, type),
         {:ok, children} <- get_children(node),
         {:ok, joint} <- reduce_oks(children, joint, &parse(&1, &2)) do
      {:ok, Robot.add_joint(robot, joint)}
    end
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
    with {:ok, name} <- get_attribute_value(node, :link) do
      {:ok, %{joint | parent_name: name}}
    end
  end

  defp parse(:child, node, %Robot.Joint{} = joint) do
    with {:ok, name} <- get_attribute_value(node, :link) do
      {:ok, %{joint | child_name: name}}
    end
  end

  defp parse(:visual, node, %Robot.Link{} = link) do
    with {:ok, children} <- get_children(node),
         visual <- Robot.Visual.init(),
         {:ok, visual} <- reduce_oks(children, visual, &parse(&1, &2)) do
      {:ok, Robot.Link.visual(link, visual)}
    end
  end

  defp parse(:geometry, node, %Robot.Visual{} = visual) do
    with {:ok, children} <- get_children(node),
         {:ok, geometries} <- reduce_oks(children, [], &parse(&1, &2)),
         do: {:ok, Robot.Visual.geometries(visual, geometries)}
  end

  defp parse(:cylinder, node, geometries) when is_list(geometries) do
    with [length] <- extract_floats(node, :length, [0]),
         [radius] <- extract_floats(node, :radius, [0]),
         cylinder <- Geometry.Cylinder.init(length, radius),
         {:ok, children} <- get_children(node),
         {:ok, cylinder} <- reduce_oks(children, cylinder, &parse(&1, &2)),
         do: {:ok, [cylinder | geometries]}
  end

  defp parse(:box, node, geometries) when is_list(geometries) do
    with [x, y, z] <- extract_floats(node, :size, [0, 0, 0]),
         box <- Geometry.Box.init(x, y, z),
         {:ok, children} <- get_children(node),
         {:ok, box} <- reduce_oks(children, box, &parse(&1, &2)),
         do: {:ok, [box | geometries]}
  end

  defp parse(:sphere, node, geometries) when is_list(geometries) do
    with [radius] <- extract_floats(node, :radius, [0]),
         sphere <- Geometry.Sphere.init(radius),
         do: {:ok, [sphere | geometries]}
  end

  defp parse(:material, node, %Robot.Visual{} = visual) do
    with {:ok, name} <- get_attribute_value(node, :name),
         do: {:ok, Robot.Visual.material_name(visual, name)}
  end

  defp parse(:origin, node, parent) do
    [roll, pitch, yaw] =
      node
      |> extract_floats(:rpy, [0, 0, 0])
      |> Enum.map(&Angle.Radian.init(&1))

    [x, y, z] = extract_floats(node, :xyz, [0, 0, 0])

    orientation = Orientations.Euler.init(:xyz, roll, pitch, yaw)
    translation = Coordinates.Cartesian.init(x, y, z)
    frame = Frame.init(translation, orientation)

    case parent do
      %Robot.Joint{} -> {:ok, Robot.Joint.origin(parent, frame)}
      %Robot.Visual{} -> {:ok, Robot.Visual.origin(parent, frame)}
    end
  end

  defp parse(:mesh, node, parent) do
    with {:ok, filename} <- get_attribute_value(node, :filename),
         do: {:ok, [Geometry.Mesh.init(filename) | parent]}
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
