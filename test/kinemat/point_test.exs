defmodule KinematPointTest do
  use Kinemat
  use Kinemat.Coordinates
  use ExUnit.Case

  defp pretty_much_equal(lhs, rhs) when is_number(lhs) and is_number(rhs) do
    assert_in_delta lhs, rhs, 0.000000001
  end

  defp pretty_much_equal(%Angle{} = lhs, rhs) do
    {_, lhs} = Angle.to_radians(lhs)
    pretty_much_equal(lhs, rhs)
  end

  defp pretty_much_equal(lhs, %Angle{} = rhs) do
    {_, rhs} = Angle.to_radians(rhs)
    pretty_much_equal(lhs, rhs)
  end

  test "cartesian -> cylindrical -> cartesian is correct" do
    point = Cartesian.init(3, 4, 7)

    result =
      point
      |> Point.to_cylindrical()
      |> Point.to_cartesian()

    pretty_much_equal(point.x, result.x)
    pretty_much_equal(point.y, result.y)
    pretty_much_equal(point.z, result.z)
  end

  test "cartesian -> spherical -> cartesian is correct" do
    point = Cartesian.init(3, 4, 7)

    result =
      point
      |> Point.to_spherical()
      |> Point.to_cartesian()

    pretty_much_equal(point.x, result.x)
    pretty_much_equal(point.y, result.y)
    pretty_much_equal(point.z, result.z)
  end

  test "cylindrical -> cartesian -> cylindrical" do
    point = Cylindrical.init(30, ~a(10)d, 9)

    result =
      point
      |> Point.to_cartesian()
      |> Point.to_cylindrical()

    pretty_much_equal(point.radial, result.radial)
    pretty_much_equal(point.azimuth, result.azimuth)
    pretty_much_equal(point.vertical, result.vertical)
  end

  test "cylindrical -> spherical -> cylindrical" do
    point = Cylindrical.init(30, ~a(10)d, 9)

    result =
      point
      |> Point.to_spherical()
      |> Point.to_cylindrical()

    pretty_much_equal(point.radial, result.radial)
    pretty_much_equal(point.azimuth, result.azimuth)
    pretty_much_equal(point.vertical, result.vertical)
  end

  test "spherical -> cartesian -> spherical" do
    point = Spherical.init(30, ~a(20)d, ~a(60)d)

    result =
      point
      |> Point.to_cartesian()
      |> Point.to_spherical()

    pretty_much_equal(point.radial, result.radial)
    pretty_much_equal(point.azimuth, result.azimuth)
    pretty_much_equal(point.polar, result.polar)
  end

  test "spherical -> cylindrical -> spherical" do
    point = Spherical.init(30, ~a(20)d, ~a(60)d)

    result =
      point
      |> Point.to_cylindrical()
      |> Point.to_spherical()

    pretty_much_equal(point.radial, result.radial)
    pretty_much_equal(point.azimuth, result.azimuth)
    pretty_much_equal(point.polar, result.polar)
  end
end
