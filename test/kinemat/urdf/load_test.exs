defmodule Kinemat.URDF.LoadTest do
  use ExUnit.Case, async: true
  import Kinemat.URDF.Load
  import Angle.Sigil
  import KinematTest.FileHelpers
  alias Kinemat.{Coordinates.Cartesian, Geometry, Orientations.Euler, Robot}

  describe "load/1" do
    test "when the file doesn't exist it returns an error" do
      assert {:error, _} = load(fixture_path("urdf/fake.file"))
    end

    test "it parses `one_shape.urdf`" do
      assert {:ok, robot} = load(fixture_path("urdf/one_shape.urdf"))

      assert robot.name == "myfirst"
      assert [link] = robot.links
      assert link.name == "base_link"
      assert [shape] = link.visual.geometries
      assert shape.__struct__ == Geometry.Cylinder
      assert shape.length == 0.6
      assert shape.radius == 0.2
    end

    test "it parses `multiple_shapes.urdf`" do
      assert {:ok, robot} = load(fixture_path("urdf/multiple_shapes.urdf"))

      assert robot.name == "multipleshapes"
      assert [link0, link1] = robot.links
      assert link0.name == "right_leg"
      assert [shape] = link0.visual.geometries
      assert shape.__struct__ == Geometry.Box
      assert shape.x == 0.6
      assert shape.y == 0.1
      assert shape.z == 0.2
      assert link1.name == "base_link"
      assert [joint] = robot.joints
      assert joint.name == "base_to_right_leg"
      assert joint.type == "fixed"
      assert joint.parent_name == "base_link"
      assert joint.child_name == "right_leg"
    end
  end

  test "it parses `origins.urdf`" do
    {:ok, robot} = load(fixture_path("urdf/origins.urdf"))

    assert [joint] = robot.joints
    assert joint.origin.point.x == 0
    assert joint.origin.point.y == -0.22
    assert joint.origin.point.z == 0.25

    assert {:ok, link} = Robot.get_link(robot, "right_leg")
    assert link.visual.origin.orientation.__struct__ == Euler
    assert link.visual.origin.orientation.representation == :xyz
    assert link.visual.origin.orientation.x == ~a(0)
    assert link.visual.origin.orientation.y == ~a(1.57075)r
    assert link.visual.origin.orientation.z == ~a(0)
    assert link.visual.origin.point.__struct__ == Cartesian
    assert link.visual.origin.point.x == 0
    assert link.visual.origin.point.y == 0
    assert link.visual.origin.point.z == -0.3
  end

  test "it parses `materials.urdf`" do
    {:ok, robot} = load(fixture_path("urdf/materials.urdf"))

    assert [materials0, materials1] = robot.materials

    assert materials0.name == "white"
    assert materials0.colour.r == 1
    assert materials0.colour.g == 1
    assert materials0.colour.b == 1
    assert materials0.colour.a == 1

    assert materials1.name == "blue"
    assert materials1.colour.r == 0
    assert materials1.colour.g == 0
    assert materials1.colour.b == 0.8
    assert materials1.colour.a == 1

    assert {:ok, link} = Robot.get_link(robot, "base_link")
    assert link.visual.material_name == "blue"

    assert {:ok, link} = Robot.get_link(robot, "right_leg")
    assert link.visual.material_name == "white"
  end

  test "it parses `visual.urdf`" do
    {:ok, robot} = load(fixture_path("urdf/visual.urdf"))

    assert {:ok, link} = Robot.get_link(robot, "left_gripper")
    assert [mesh] = link.visual.geometries
    assert mesh.filename == "package://urdf_tutorial/meshes/l_finger.dae"

    assert {:ok, link} = Robot.get_link(robot, "left_tip")
    assert [mesh] = link.visual.geometries
    assert mesh.filename == "package://urdf_tutorial/meshes/l_finger_tip.dae"

    assert {:ok, link} = Robot.get_link(robot, "right_gripper")
    assert [mesh] = link.visual.geometries
    assert mesh.filename == "package://urdf_tutorial/meshes/l_finger.dae"

    assert {:ok, link} = Robot.get_link(robot, "right_tip")
    assert [mesh] = link.visual.geometries
    assert mesh.filename == "package://urdf_tutorial/meshes/l_finger_tip.dae"

    assert {:ok, link} = Robot.get_link(robot, "head")
    assert [sphere] = link.visual.geometries
    assert sphere.radius == 0.2
  end
end
