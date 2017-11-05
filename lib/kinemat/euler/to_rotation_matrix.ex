defmodule Kinemat.Euler.ToRotationMatrix do
  use Kinemat
  import Kinemat.Trig, only: [cos: 1, sin: 1]

  @moduledoc """
  Module to handle conversion of Euler angles into rotation matrices.

  Used by the `Orientation` implementation.
  """

  @doc """
  Convert an Euler orientation into a rotation matrix.
  """
  @spec to_rotation_matrix(Euler.t) :: RotationMatrix.t
  def to_rotation_matrix(%Euler{representation: order, x: x, y: y, z: z}) do
    a = cos(x)
    b = sin(x)
    c = cos(y)
    d = sin(y)
    e = cos(z)
    f = sin(z)

    order
    |> build_rotation({a, b, c, d, e, f})
    |> RotationMatrix.init
  end

  defp build_rotation(:xyz, {a, b, c, d, e, f}) do
    ae  = a * e
    af  = a * f
    be  = b * e
    bf  = b * f

    m00 = c * e
    m10 = - c * f
    m20 = d

    m01 = af + be * d
    m11 = ae - bf * d
    m21 = - b * c

    m02 = bf - ae * d
    m12 = be + af * d
    m22 = a * c

    {m00, m01, m02,
     m10, m11, m12,
     m20, m21, m22}
  end

  defp build_rotation(:yxz, {a, b, c, d, e, f}) do
    ce  = c * e
    cf  = c * f
    de  = d * e
    df  = d * f

    m00 = ce + df * b
    m10 = de * b - cf
    m20 = a * d

    m01 = a * f
    m11 = a * e
    m21 = - b

    m02 = cf * b - de
    m12 = df + ce * b
    m22 = a * c

    {m00, m01, m02,
     m10, m11, m12,
     m20, m21, m22}
  end

  defp build_rotation(:zxy, {a, b, c, d, e, f}) do
    ce  = c * e
    cf  = c * f
    de  = d * e
    df  = d * f

    m00 = ce - df * b
    m10 = - a * f
    m20 = de + cf * b

    m01 = cf + de * b
    m11 = a * e
    m21 = df - ce * b

    m02 = - a * d
    m12 = b
    m22 = a * c

    {m00, m01, m02,
     m10, m11, m12,
     m20, m21, m22}
  end

  defp build_rotation(:zyx, {a, b, c, d, e, f}) do
    ae  = a * e
    af  = a * f
    be  = b * e
    bf  = b * f

    m00 = c * e
    m10 = be * d - af
    m20 = ae * d + bf

    m01 = c * f
    m11 = bf * d + ae
    m21 = af * d - be

    m02 = - d
    m12 = b * c
    m22 = a * c

    {m00, m01, m02,
     m10, m11, m12,
     m20, m21, m22}
  end

  defp build_rotation(:yzx, {a, b, c, d, e, f}) do
    ac  = a * c
    ad  = a * d
    bc  = b * c
    bd  = b * d

    m00 = c * e
    m10 = bd - ac * f
    m20 = bc * f + ad

    m01 = f
    m11 = a * e
    m21 = - b * e

    m02 = - d * e
    m12 = ad * f + bc
    m22 = ac - bd * f

    {m00, m01, m02,
     m10, m11, m12,
     m20, m21, m22}
  end

  defp build_rotation(:xzy, {a, b, c, d, e, f}) do
    ac  = a * c
    ad  = a * d
    bc  = b * c
    bd  = b * d

    m00 = c * e
    m10 = - f
    m20 = d * e

    m01 = ac * f + bd
    m11 = a * e
    m21 = ad * f - bc

    m02 = bc * f - ad
    m12 = b * e
    m22 = bd * f + ac

    {m00, m01, m02,
     m10, m11, m12,
     m20, m21, m22}
  end

end
