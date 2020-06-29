defmodule Kinemat.URDF.Save do
  alias Kinemat.{
    Coordinates.Cartesian,
    Frame,
    Geometry,
    Orientation,
    Orientations.Euler,
    Point,
    Robot
  }

  @moduledoc """
  This module implements the ability to save a URDF file using the `:xmerl` OTP
  library.
  """

  @doc """
  Attempt to save a `Robot` to an URDF XML file.
  """
  @spec save(Robot.t(), Path.t()) :: :ok | {:error, any}
  def save(%Robot{} = robot, path) do
    data =
      [robot]
      |> Enum.map(&to_tag(&1))
      |> :xmerl.export_simple(:xmerl_xml)

    File.write(path, data)
  end

  defp to_tag(%Robot{name: name, materials: materials, joints: joints, links: links}) do
    contents =
      materials
      |> Enum.map(&to_tag(&1))

    contents =
      links
      |> Enum.map(&to_tag(&1))
      |> Enum.concat(contents)

    contents =
      joints
      |> Enum.map(&to_tag(&1))
      |> Enum.concat(contents)

    {:robot, [name: name], Enum.reverse(contents)}
  end

  defp to_tag(%Robot.Material{name: name, colour: colour}),
    do: {:material, [name: name], [to_tag(colour)]}

  defp to_tag(%Robot.Colour{r: r, g: g, b: b, a: a}) do
    rgba =
      [r, g, b, a]
      |> Stream.map(&to_string(&1))
      |> Enum.join(" ")

    {:color, [rgba: rgba], []}
  end

  defp to_tag(%Robot.Link{name: name, visual: nil}),
    do: {:link, [name: name], []}

  defp to_tag(%Robot.Link{name: name, visual: visual}),
    do: {:link, [name: name], [to_tag(visual)]}

  defp to_tag(%Robot.Visual{geometries: geometries, origin: origin, material_name: material_name}) do
    geometries =
      geometries
      |> Enum.map(&to_tag(&1))

    contents =
      if Enum.any?(geometries),
        do: [{:geometry, [], geometries}],
        else: []

    contents =
      if origin,
        do: [to_tag(origin) | contents],
        else: contents

    contents =
      if material_name,
        do: [{:material, [name: material_name], []} | contents],
        else: contents

    {:visual, [], Enum.reverse(contents)}
  end

  defp to_tag(%Geometry.Box{x: x, y: y, z: z}) do
    size =
      [x, y, z]
      |> Stream.map(&to_string(&1))
      |> Enum.join(" ")

    {:box, [size: size], []}
  end

  defp to_tag(%Geometry.Sphere{radius: radius}),
    do: {:sphere, [radius: to_string(radius)], []}

  defp to_tag(%Geometry.Mesh{filename: filename}),
    do: {:mesh, [filename: filename], []}

  defp to_tag(%Geometry.Cylinder{length: length, radius: radius}),
    do: {:cylinder, [length: to_string(length), radius: to_string(radius)], []}

  defp to_tag(%Frame{point: translation, orientation: orientation}) do
    orientation =
      orientation
      |> Orientation.to_euler(:xyz)

    rpy =
      [:x, :y, :z]
      |> Stream.map(&apply(Euler, &1, [orientation]))
      |> Stream.map(&Angle.to_radians(&1))
      |> Stream.map(&elem(&1, 1))
      |> Stream.map(&to_string(&1))
      |> Enum.join(" ")

    translation =
      translation
      |> Point.to_cartesian()

    xyz =
      [:x, :y, :z]
      |> Stream.map(&apply(Cartesian, &1, [translation]))
      |> Stream.map(&to_string(&1))
      |> Enum.join(" ")

    {:origin, [rpy: rpy, xyz: xyz], []}
  end

  defp to_tag(%Robot.Joint{name: name, type: type} = joint) do
    contents = []

    contents =
      if joint.parent_name,
        do: [{:parent, [name: joint.parent_name], []} | contents],
        else: contents

    contents =
      if joint.child_name,
        do: [{:child, [name: joint.child_name], []} | contents],
        else: contents

    contents =
      if joint.origin,
        do: [to_tag(joint.origin) | contents],
        else: contents

    {:joint, [name: name, type: type], contents}
  end
end
