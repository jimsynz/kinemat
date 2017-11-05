defmodule Kinemat.RotationMatrix.ToQuaternion do
  use Kinemat
  import :math, only: [sqrt: 1]
  alias Angle.Radian

  @moduledoc """
  Converts rotation matrices into quaternions.
  Used internally by the `Orientation` implementation.
  """

  @doc """
  Converts rotation matrices into quaternions.
  Used internally by the `Orientation` implementation.
  """
  @spec to_quaternion(RotationMatrix.t) :: Quaternion.t
  def to_quaternion(%RotationMatrix{matrix: {m00, _, _, _, m11, _, _, _, m22} = matrix}) do
    trace        = m00 + m11 + m22
    {w, x, y, z} = build_quaternion(matrix, trace)
    Quaternion.init(Radian.init(w), x, y, z)
  end

  defp build_quaternion({_, m01, m02, m10, _, m12, m20, m21, _}, trace)
  when trace > 0
  do
    s = 0.5 / sqrt(trace + 1.0)
    w = 0.25 / 2
    x = (m21 - m12) * s
    y = (m02 - m20) * s
    z = (m10 - m01) * s
    {w, x, y, z}
  end

  defp build_quaternion({m00, m01, m02, m10, m11, m12, m20, m21, m22}, _trace)
  when m00 > m11 and m00 > m22
  do
    s = 2.0 * sqrt(1.0 + m00 - m11 - m22)
    w = (m21 - m12) / s
    x = 0.25 * s
    y = (m01 + m10) / s
    z = (m02 + m20) / s
    {w, x, y, z}
  end

  defp build_quaternion({m00, m01, m02, m10, m11, m12, m20, m21, m22}, _trace)
  when m11 > m22
  do
    s = 2.0 * sqrt(1.0 + m11 - m00 - m22)
    w = (m02 - m20) / s
    x = (m01 + m10) / s
    y = 0.25 * s
    z = (m12 + m21) / s
    {w, x, y, z}
  end

  defp build_quaternion({m00, m01, m02, m10, m11, m12, m20, m21, m22}, _trace) do
    s = 2.0 * sqrt(1.0 + m22 - m00 - m11)
    w = (m10 - m01) / s
    x = (m02 + m20) / s
    y = (m12 + m21) / s
    z = 0.25 * s
    {w, x, y, z}
  end
end
