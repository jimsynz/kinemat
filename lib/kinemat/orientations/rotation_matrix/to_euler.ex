defmodule Kinemat.Orientations.RotationMatrix.ToEuler do
  use Kinemat
  use Kinemat.Orientations
  alias Angle.Radian
  import :math, only: [asin: 1, atan2: 2]

  @moduledoc """
  Implements the conversion from rotation matrix to Euler angles.

  Used internally by the Orientation implementation.
  """

  @doc """
  Convert a RotationMatrix into an :xyz Euler.
  """
  @spec to_euler(RotationMatrix.t()) :: Euler.t()
  def to_euler(orientation), do: to_euler(orientation, :xyz)

  @doc """
  Convert a RotationMatrix into a Euler of the specified order.
  """
  @spec to_euler(RotationMatrix.t(), Euler.valid_orientation()) :: Euler.t()
  def to_euler(%RotationMatrix{matrix: matrix}, representation) do
    {x, y, z} = compute_euler(matrix, representation)
    Euler.init(representation, Radian.init(x), Radian.init(y), Radian.init(z))
  end

  defp compute_euler({m00, m01, m02, _, _, m12, _, _, m22}, :xyz)
       when abs(m02) < 0.99999 do
    y = m02 |> clamp |> asin()
    x = atan2(0 - m12, m22)
    z = atan2(0 - m01, m00)
    {x, y, z}
  end

  defp compute_euler({_, _, m02, _, m11, _, _, m21, _}, :xyz) do
    y = m02 |> clamp |> asin()
    x = atan2(m21, m11)
    z = 0
    {x, y, z}
  end

  defp compute_euler({_, _, m02, m10, m11, m12, _, _, m22}, :yxz)
       when abs(m12) < 0.99999 do
    x = asin(0 - clamp(m12))
    y = atan2(m02, m22)
    z = atan2(m10, m11)
    {x, y, z}
  end

  defp compute_euler({m00, _, _, _, _, m12, m20, _, _}, :yxz) do
    x = asin(0 - clamp(m12))
    y = atan2(0 - m20, m00)
    z = 0
    {x, y, z}
  end

  defp compute_euler({_, m01, _, _, m11, _, m20, m21, m22}, :zxy)
       when abs(m21) < 0.99999 do
    x = m21 |> clamp |> asin()
    y = atan2(0 - m20, m22)
    z = atan2(0 - m01, m11)
    {x, y, z}
  end

  defp compute_euler({m00, _, _, m10, _, _, _, m21, _}, :zxy) do
    x = m21 |> clamp |> asin()
    y = 0
    z = atan2(m10, m00)
    {x, y, z}
  end

  defp compute_euler({m00, _, _, m10, _, _, m20, m21, m22}, :zyx)
       when abs(m20) < 0.99999 do
    y = asin(0 - clamp(m20))
    x = atan2(m21, m22)
    z = atan2(m10, m00)
    {x, y, z}
  end

  defp compute_euler({_, m01, _, _, m11, _, m20, _, _}, :zyx) do
    y = asin(0 - clamp(m20))
    x = 0
    z = atan2(0 - m01, m11)
    {x, y, z}
  end

  defp compute_euler({m00, _, _, m10, m11, m12, m20, _, _}, :yzx)
       when abs(m10) < 0.99999 do
    z = m10 |> clamp |> asin()
    x = atan2(0 - m12, m11)
    y = atan2(0 - m20, m00)
    {x, y, z}
  end

  defp compute_euler({_, _, m02, m10, _, _, _, _, m22}, :yzx) do
    z = m10 |> clamp |> asin()
    x = 0
    y = atan2(m02, m22)
    {x, y, z}
  end

  defp compute_euler({m00, m01, m02, _, m11, _, _, m21, _}, :xzy)
       when abs(m01) < 0.99999 do
    z = asin(0 - clamp(m01))
    x = atan2(m21, m11)
    y = atan2(m02, m00)
    {x, y, z}
  end

  defp compute_euler({_, m01, _, _, _, m12, _, _, m22}, :xzy) do
    z = asin(0 - clamp(m01))
    x = atan2(0 - m12, m22)
    y = 0
    {x, y, z}
  end

  defp clamp(value) when value < -1, do: -1
  defp clamp(value) when value > 1, do: 1
  defp clamp(value), do: value
end
