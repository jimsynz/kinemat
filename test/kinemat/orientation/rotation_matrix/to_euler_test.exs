defmodule Kinemat.RotationMatrixToEulerTest do
  use ExUnit.Case
  use Kinemat
  use Kinemat.Orientations
  alias Angle.Radian
  doctest Kinemat.Orientations.RotationMatrix.ToEuler

  @rotation RotationMatrix.init({0, 1, 0, 1, 0, 0, 0, 0, -1})

  # These results were computed using the Mittsu ruby gem.
  @computed_results %{
    xyz: {3.141592653589793, 0.0, -1.5707963267948966},
    yxz: {0.0, 3.141592653589793, 1.5707963267948966},
    zxy: {0.0, 3.141592653589793, -1.5707963267948966},
    zyx: {3.141592653589793, 0.0, 1.5707963267948966},
    yzx: {0.0, 3.141592653589793, 1.5707963267948966},
    xzy: {3.141592653589793, 0.0, -1.5707963267948966}
  }

  Enum.each(@computed_results, fn {orientation, {x, y, z}} ->
    upcased = orientation |> to_string() |> String.upcase()

    test "converting to #{upcased} Euler" do
      computed =
        RotationMatrix.ToEuler.to_euler(@rotation, unquote(orientation))

      correct =
        Euler.init(
          unquote(orientation),
          Radian.init(unquote(x)),
          Radian.init(unquote(y)),
          Radian.init(unquote(z))
        )

      assert computed == correct
    end
  end)
end
