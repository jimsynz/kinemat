defmodule Kinemat.Orientations.Euler.ToQuaternion do
  use Kinemat
  use Kinemat.Orientations
  import :math, only: [cos: 1, sin: 1]
  alias Angle.Radian

  @moduledoc """
  Implements the conversion of Euler angles to Quaternions.

  Used internally by the orientation protocol.
  """

  @doc """
  Converts Euler orientations into Quaternions.
  """
  @spec to_quaternion(Euler.t()) :: Quaternion.t()
  def to_quaternion(%Euler{representation: order, x: x, y: y, z: z}) do
    {_, x} = Angle.to_radians(x)
    {_, y} = Angle.to_radians(y)
    {_, z} = Angle.to_radians(z)

    x2 = x / 2
    y2 = y / 2
    z2 = z / 2

    c1 = cos(x2)
    c2 = cos(y2)
    c3 = cos(z2)

    s1 = sin(x2)
    s2 = sin(y2)
    s3 = sin(z2)

    build_quaternion(order, {c1, c2, c3, s1, s2, s3})
  end

  defp build_quaternion(:xyz, {c1, c2, c3, s1, s2, s3}) do
    x = s1 * c2 * c3 + c1 * s2 * s3
    y = c1 * s2 * c3 - s1 * c2 * s3
    z = c1 * c2 * s3 + s1 * s2 * c3
    w = c1 * c2 * c3 - s1 * s2 * s3
    Quaternion.init(Radian.init(w), x, y, z)
  end

  defp build_quaternion(:yxz, {c1, c2, c3, s1, s2, s3}) do
    x = s1 * c2 * c3 + c1 * s2 * s3
    y = c1 * s2 * c3 - s1 * c2 * s3
    z = c1 * c2 * s3 - s1 * s2 * c3
    w = c1 * c2 * c3 + s1 * s2 * s3
    Quaternion.init(Radian.init(w), x, y, z)
  end

  defp build_quaternion(:zxy, {c1, c2, c3, s1, s2, s3}) do
    x = s1 * c2 * c3 - c1 * s2 * s3
    y = c1 * s2 * c3 + s1 * c2 * s3
    z = c1 * c2 * s3 + s1 * s2 * c3
    w = c1 * c2 * c3 - s1 * s2 * s3
    Quaternion.init(Radian.init(w), x, y, z)
  end

  defp build_quaternion(:zyx, {c1, c2, c3, s1, s2, s3}) do
    x = s1 * c2 * c3 - c1 * s2 * s3
    y = c1 * s2 * c3 + s1 * c2 * s3
    z = c1 * c2 * s3 - s1 * s2 * c3
    w = c1 * c2 * c3 + s1 * s2 * s3
    Quaternion.init(Radian.init(w), x, y, z)
  end

  defp build_quaternion(:yzx, {c1, c2, c3, s1, s2, s3}) do
    x = s1 * c2 * c3 + c1 * s2 * s3
    y = c1 * s2 * c3 + s1 * c2 * s3
    z = c1 * c2 * s3 - s1 * s2 * c3
    w = c1 * c2 * c3 - s1 * s2 * s3
    Quaternion.init(Radian.init(w), x, y, z)
  end

  defp build_quaternion(:xzy, {c1, c2, c3, s1, s2, s3}) do
    x = s1 * c2 * c3 - c1 * s2 * s3
    y = c1 * s2 * c3 - s1 * c2 * s3
    z = c1 * c2 * s3 + s1 * s2 * c3
    w = c1 * c2 * c3 + s1 * s2 * s3
    Quaternion.init(Radian.init(w), x, y, z)
  end
end
