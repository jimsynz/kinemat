defmodule Kinemat.Orientation.EulerToRotationMatrixTest do
  use ExUnit.Case
  use Kinemat
  import Kinemat.Euler.ToRotationMatrix, only: [to_rotation_matrix: 1]
  doctest Kinemat.Euler.ToRotationMatrix

  @deg_30 ~a(30)d
  @deg_20 ~a(20)d
  @deg_15 ~a(15)d

  # These results were computed using the Mittsu ruby gem.
  @computed_results %{
    xyz: { 0.9076733711903687,   0.3893269128166894,  -0.15669590354740334,
          -0.24321034680169396,  0.7922556402871195,   0.5596246310178333,
           0.3420201433256687,  -0.46984631039295416,  0.8137976813493738},
    yxz: { 0.9519340346410572,   0.2241438680420134,  -0.20876091614850517,
          -0.07802730202701791,  0.8365163037378079,   0.5423580124965611,
           0.29619813272602386, -0.49999999999999994,  0.8137976813493738},
    zxy: { 0.8634127077396803,   0.40839339157637,    -0.29619813272602386,
          -0.2241438680420134,   0.8365163037378079,   0.49999999999999994,
           0.4519712629501991,  -0.36531535869380743,  0.8137976813493738},
    zyx: { 0.9076733711903687,   0.24321034680169396, -0.3420201433256687,
          -0.05896082326733734,  0.8807769671884964,   0.46984631039295416,
           0.415514948649924,   -0.40630119527123487,  0.8137976813493738},
    yzx: { 0.9076733711903687,   0.25881904510252074, -0.33036608954935215,
          -0.03961626713065605,  0.8365163037378079,   0.5465080282662533,
           0.41780330612687083, -0.4829629131445341,   0.7695370178986853},
    xzy: { 0.9076733711903687,   0.3816364104563247,  -0.17459295932517688,
          -0.25881904510252074,  0.8365163037378079,   0.4829629131445341,
           0.33036608954935215, -0.393184592519655,    0.8580583448000623}
  }

  Enum.each(@computed_results, fn
    {orientation, {m00, m01, m02, m10, m11, m12, m20, m21, m22}} ->
      test "converting from #{orientation} Euler to rotation matrix" do
        euler    = Euler.init(unquote(orientation), @deg_30, @deg_20, @deg_15)
        computed = to_rotation_matrix(euler)
        correct  = {unquote(m00), unquote(m01), unquote(m02),
                    unquote(m10), unquote(m11), unquote(m12),
                    unquote(m20), unquote(m21), unquote(m22)}
                   |> RotationMatrix.init()
        assert computed == correct
      end
  end)
end
