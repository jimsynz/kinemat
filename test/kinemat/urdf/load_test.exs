defmodule Kinemat.URDF.LoadTest do
  use ExUnit.Case, async: true
  import Kinemat.URDF.Load
  import Angle.Sigil
  import KinematTest.FileHelpers

  alias Kinemat.{
    Coordinates.Cartesian,
    Frame,
    Geometry,
    Orientations.Euler,
    Orientations.RotationMatrix,
    Robot
  }

  @angle_04 ~a(0.4)r
  @angle_05 ~a(0.5)r
  @angle_06 ~a(0.6)r

  describe "load/1" do
    test "when the file doesn't exist it returns an error" do
      assert {:error, _} = load(fixture_path("urdf/fake.file"))
    end

    test "it loads and parses `one_shape.urdf`" do
      assert {:ok, robot} = load(fixture_path("urdf/one_shape.urdf"))

      assert robot.name == "myfirst"
      assert [link] = robot.links
      assert link.name == "base_link"
      assert shape = link.visual.geometry
      assert shape.__struct__ == Geometry.Cylinder
      assert shape.length == 0.6
      assert shape.radius == 0.2
    end

    test "it loads and parses `multiple_shapes.urdf`" do
      assert {:ok, robot} = load(fixture_path("urdf/multiple_shapes.urdf"))

      assert robot.name == "multipleshapes"
      assert [link0, link1] = robot.links
      assert link0.name == "right_leg"
      assert shape = link0.visual.geometry
      assert shape.__struct__ == Geometry.Box
      assert shape.x == 0.6
      assert shape.y == 0.1
      assert shape.z == 0.2
      assert link1.name == "base_link"
      assert [joint] = robot.joints
      assert joint.name == "base_to_right_leg"
      assert joint.type == :fixed
      assert joint.parent_name == "base_link"
      assert joint.child_name == "right_leg"
    end

    test "it loads and parses `origins.urdf`" do
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

    test "it loads and parses `materials.urdf`" do
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
      assert link.visual.material.name == "blue"

      assert {:ok, link} = Robot.get_link(robot, "right_leg")
      assert link.visual.material.name == "white"
    end

    test "it loads and parses `visual.urdf`" do
      {:ok, robot} = load(fixture_path("urdf/visual.urdf"))

      assert {:ok, link} = Robot.get_link(robot, "left_gripper")
      assert mesh = link.visual.geometry
      assert mesh.filename == "package://urdf_tutorial/meshes/l_finger.dae"

      assert {:ok, link} = Robot.get_link(robot, "left_tip")
      assert mesh = link.visual.geometry
      assert mesh.filename == "package://urdf_tutorial/meshes/l_finger_tip.dae"

      assert {:ok, link} = Robot.get_link(robot, "right_gripper")
      assert mesh = link.visual.geometry
      assert mesh.filename == "package://urdf_tutorial/meshes/l_finger.dae"

      assert {:ok, link} = Robot.get_link(robot, "right_tip")
      assert mesh = link.visual.geometry
      assert mesh.filename == "package://urdf_tutorial/meshes/l_finger_tip.dae"

      assert {:ok, link} = Robot.get_link(robot, "head")
      assert sphere = link.visual.geometry
      assert sphere.radius == 0.2
    end

    test "it loads and parses `flexible.urdf`" do
      {:ok, robot} = load(fixture_path("urdf/flexible.urdf"))

      assert {:ok, joint} = Robot.get_joint(robot, "right_front_wheel_joint")
      assert Cartesian.x(joint.axis) == 0
      assert Cartesian.y(joint.axis) == 1.0
      assert Cartesian.z(joint.axis) == 0

      assert {:ok, joint} = Robot.get_joint(robot, "gripper_extension")
      assert joint.limit.effort == 1000.0
      assert joint.limit.lower == -0.38
      assert joint.limit.upper == 0
      assert joint.limit.velocity == 0.5
    end

    test "it loads and parses `physics.urdf`" do
      {:ok, robot} = load(fixture_path("urdf/physics.urdf"))

      assert {:ok, link} = Robot.get_link(robot, "base_link")
      assert %Geometry.Cylinder{length: 0.6, radius: 0.2} = link.collision.geometry

      assert link.inertia.mass == 10
      assert {1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0} = link.inertia.matrix.matrix
    end
  end

  describe "parse/1" do
    test "it parses the robot element" do
      {:ok, robot} = parse(~S[<robot name="Marty McFly"/>])
      assert robot.name == "Marty McFly"
    end

    test "it parses a transmission element" do
      xml = ~S"""
        <robot name="">
          <transmission name="simple_trans">
          </transmission>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [%Robot.Transmission{name: "simple_trans"}] = robot.transmissions
    end

    test "it parses a transmission type element" do
      xml = ~S"""
        <robot name="">
          <transmission name="simple_trans">
            <type>transmission_interface/SimpleTransmission</type>
          </transmission>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [transmission] = robot.transmissions
      assert transmission.type == "transmission_interface/SimpleTransmission"
    end

    test "it parses a transmission joint element" do
      xml = ~S"""
        <robot name="">
          <transmission name="simple_trans">
            <joint name="foo_joint" />
          </transmission>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [transmission] = robot.transmissions
      assert [%Robot.TransmissionJoint{name: "foo_joint"}] = transmission.joints
    end

    test "it parses a transmission joint containing a hardware interface element" do
      xml = ~S"""
        <robot name="">
          <transmission name="simple_trans">
            <joint name="foo_joint">
              <hardwareInterface>EffortJointInterface</hardwareInterface>
            </joint>
          </transmission>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [transmission] = robot.transmissions
      assert [joint] = transmission.joints

      assert [%Robot.HardwareInterface{name: "EffortJointInterface"}] = joint.hardware_interfaces
    end

    test "it parses a transmission actuator element" do
      xml = ~S"""
        <robot name="">
          <transmission name="simple_trans">
            <actuator name="foo_motor" />
          </transmission>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [transmission] = robot.transmissions
      assert [%Robot.Actuator{name: "foo_motor"}] = transmission.actuators
    end

    test "it parses a transmission actuator containing a mechanical reduction element" do
      xml = ~S"""
        <robot name="">
          <transmission name="simple_trans">
            <actuator name="foo_motor">
              <mechanicalReduction>50</mechanicalReduction>
            </actuator>
          </transmission>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [transmission] = robot.transmissions
      assert [actuator] = transmission.actuators
      assert actuator.mechanical_reduction == 50
    end

    test "it parses a transmission actuator containing a hardware interface element" do
      xml = ~S"""
        <robot name="">
          <transmission name="simple_trans">
            <actuator name="foo_motor">
              <hardwareInterface>EffortJointInterface</hardwareInterface>
            </actuator>
          </transmission>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [transmission] = robot.transmissions
      assert [actuator] = transmission.actuators

      assert [%Robot.HardwareInterface{name: "EffortJointInterface"}] =
               actuator.hardware_interfaces
    end

    test "it parses a link element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link" />
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [%Robot.Link{name: "my_link"}] = robot.links
    end

    test "it parses a link containing an inertial element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <inertial />
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Robot.Inertia{} = link.inertia
    end

    test "it parses a link containing an inertial origin element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <inertial>
              <origin xyz="0.1 0.2 0.3" rpy="0.4 0.5 0.6"/>
            </inertial>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links

      assert %Frame{
               point: %Cartesian{x: 0.1, y: 0.2, z: 0.3},
               orientation: %Euler{x: @angle_04, y: @angle_05, z: @angle_06, representation: :xyz}
             } = link.inertia.origin
    end

    test "it parses a link containing an inertial mass element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <inertial>
              <mass value="1" />
            </inertial>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert link.inertia.mass == 1
    end

    test "it parses a link containing an inertial inertia element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <inertial>
              <inertia ixx="1" ixy="2" ixz="3" iyy="4" iyz="5" izz="6" />
            </inertial>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %RotationMatrix{matrix: {1, 2, 3, 2, 4, 5, 3, 5, 6}}
    end

    test "it parses a link containing an visual element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual />
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Robot.Visual{} = link.visual
    end

    test "it parses a link containing an visual origin element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <origin xyz="0.1 0.2 0.3" rpy="0.4 0.5 0.6"/>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links

      assert %Frame{
               point: %Cartesian{x: 0.1, y: 0.2, z: 0.3},
               orientation: %Euler{x: @angle_04, y: @angle_05, z: @angle_06, representation: :xyz}
             } = link.visual.origin
    end

    test "it parses a link containing a visual geometry element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <geometry/>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      refute link.visual.geometry
    end

    test "it parses a link containing a visual geometry box" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <geometry>
                <box size="1 2 3" />
              </geometry>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Geometry.Box{x: 1.0, y: 2.0, z: 3.0} = link.visual.geometry
    end

    test "it parses a link containing a visual geometry cylinder" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <geometry>
                <cylinder length="1" radius="2" />
              </geometry>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Geometry.Cylinder{length: 1.0, radius: 2.0} = link.visual.geometry
    end

    test "it parses a link containing a visual geometry sphere" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <geometry>
                <sphere radius="2" />
              </geometry>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Geometry.Sphere{radius: 2.0} = link.visual.geometry
    end

    test "it parses a link containing a visual geometry mesh" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <geometry>
                <mesh filename="myfile" scale="2" />
              </geometry>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Geometry.Mesh{filename: "myfile", scale: 2.0} = link.visual.geometry
    end

    test "it parses a link containing a visual material element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <material name="my material" />
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Robot.Material{name: "my material"} = link.visual.material
    end

    test "it parses a link containing a visual material color element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <material name="my material">
                <color rgba="0.25 0.5 0.75 1" />
              </material>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Robot.Colour{r: 0.25, g: 0.5, b: 0.75, a: 1.0} = link.visual.material.colour
    end

    test "it parses a link containing a visual material texture element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <material name="my material">
                <texture filename="mytexture" />
              </material>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Robot.Texture{filename: "mytexture"} = link.visual.material.texture
    end

    test "it parses a link containing a visual origin element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <visual>
              <origin xyz="0.1 0.2 0.3" rpy="0.4 0.5 0.6"/>
            </visual>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links

      assert %Frame{
               point: %Cartesian{x: 0.1, y: 0.2, z: 0.3},
               orientation: %Euler{x: @angle_04, y: @angle_05, z: @angle_06, representation: :xyz}
             } = link.visual.origin
    end

    test "it parses a link containing a collision element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <collision />
          </link>
        </robot>
      """

      assert {:ok, _robot} = parse(xml)
    end

    test "it parses a link containing a collision element with a name attribute" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <collision name="crash" />
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Robot.Collision{name: "crash"} = link.collision
    end

    test "it parses a link containing a collision origin element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <collision>
              <origin xyz="0.1 0.2 0.3" rpy="0.4 0.5 0.6"/>
            </collision>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links

      assert %Frame{
               point: %Cartesian{x: 0.1, y: 0.2, z: 0.3},
               orientation: %Euler{x: @angle_04, y: @angle_05, z: @angle_06, representation: :xyz}
             } = link.collision.origin
    end

    test "it parses a link containing a collision geometry element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <collision>
              <geometry/>
            </collision>
          </link>
        </robot>
      """

      assert {:ok, _robot} = parse(xml)
    end

    test "it parses a link containing a collision geometry box element" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <collision>
              <geometry>
                <box size="1 2 3" />
              </geometry>
            </collision>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Geometry.Box{x: 1.0, y: 2.0, z: 3.0} = link.collision.geometry
    end

    test "it parses a link containing a collision geometry cylinder" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <collision>
              <geometry>
                <cylinder length="1" radius="2" />
              </geometry>
            </collision>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Geometry.Cylinder{length: 1.0, radius: 2.0} = link.collision.geometry
    end

    test "it parses a link containing a collision geometry sphere" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <collision>
              <geometry>
                <sphere radius="2" />
              </geometry>
            </collision>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Geometry.Sphere{radius: 2.0} = link.collision.geometry
    end

    test "it parses a link containing a collision geometry mesh" do
      xml = ~S"""
        <robot name="">
          <link name="my_link">
            <collision>
              <geometry>
                <mesh filename="myfile" scale="2" />
              </geometry>
            </collision>
          </link>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [link] = robot.links
      assert %Geometry.Mesh{filename: "myfile", scale: 2.0} = link.collision.geometry
    end

    test "it parses a joint" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed" />
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [_joint] = robot.joints
    end

    test "it parses a joint origin element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <origin xyz="0.1 0.2 0.3" rpy="0.4 0.5 0.6"/>
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints

      assert %Frame{
               point: %Cartesian{x: 0.1, y: 0.2, z: 0.3},
               orientation: %Euler{x: @angle_04, y: @angle_05, z: @angle_06, representation: :xyz}
             } = joint.origin
    end

    test "it parses a joint parent element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <parent link="my_parent" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Joint{parent_name: "my_parent"} = joint
    end

    test "it parses a joint child element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <child link="my_child" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Joint{child_name: "my_child"} = joint
    end

    test "it parses a joint axis element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <axis xyz="0.1 0.2 0.3" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Cartesian{x: 0.1, y: 0.2, z: 0.3} = joint.axis
    end

    test "it parses a joint calibration element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <calibration />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Calibration{rising: nil, falling: nil} = joint.calibration
    end

    test "it parses a joint calibration element with rising and falling attributes" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <calibration rising="1" falling="2" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Calibration{rising: 1.0, falling: 2.0} = joint.calibration
    end

    test "it parses a joint dynamics element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <dynamics />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Dynamics{damping: 0, friction: 0} = joint.dynamics
    end

    test "it parses a joint dynamics element with damping and friction attributes" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <dynamics damping="1" friction="2"/>
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Dynamics{damping: 1.0, friction: 2.0} = joint.dynamics
    end

    test "it parses a joint limit element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <limit />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Limit{lower: 0, upper: 0} = joint.limit
    end

    test "it parses a joint limit element with an effort and velocity attribute" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <limit effort="13" velocity="14" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Limit{effort: 13.0, velocity: 14.0} = joint.limit
    end

    test "it parses a joint mimic element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <mimic joint="other_joint" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Mimic{joint_name: "other_joint", multiplier: 1, offset: 0} = joint.mimic
    end

    test "it parses a joint mimic element with multiplier and offset attributes" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <mimic joint="other_joint" multiplier="2" offset="3" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints
      assert %Robot.Mimic{joint_name: "other_joint", multiplier: 2.0, offset: 3.0} = joint.mimic
    end

    test "it parses a joint safety controller element" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <safety_controller k_velocity="13" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints

      assert %Robot.SafetyController{
               k_velocity: 13.0,
               k_position: 0,
               soft_lower_limit: 0,
               soft_upper_limit: 0
             } = joint.safety_controller
    end

    test "it parses a joint safety controller element with k position, soft lower limit and soft upper limit attributes" do
      xml = ~S"""
        <robot name="">
          <joint name="my_joint" type="fixed">
            <safety_controller k_velocity="13" k_position="14" soft_lower_limit="1" soft_upper_limit="2" />
          </joint>
        </robot>
      """

      assert {:ok, robot} = parse(xml)
      assert [joint] = robot.joints

      assert %Robot.SafetyController{
               k_velocity: 13.0,
               k_position: 14.0,
               soft_lower_limit: 1.0,
               soft_upper_limit: 2.0
             } = joint.safety_controller
    end

    test "it ignores the gazebo element" do
      xml = ~S"""
        <robot name="">
          <gazebo />
        </robot>
      """

      {:ok, _robot} = parse(xml)
    end
  end
end
