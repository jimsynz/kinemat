defmodule Kinemat.Orientation.EulerToQuaternionTest do
  use ExUnit.Case
  use Kinemat
  alias Angle.Radian
  import Kinemat.Euler.ToQuaternion, only: [to_quaternion: 1]
  doctest Kinemat.Euler.ToQuaternion

  @deg_30 ~a(30)d
  @deg_20 ~a(20)d
  @deg_15 ~a(15)d

  # These values computed using the Mittsu Ruby gem.
  @computed %{
    xyz:
      {0.9372468582005039, 0.2745997312243201, 0.13302686547026613,
       0.168722160571667},
    yxz:
      {0.9489794544309479, 0.2745997312243201, 0.13302686547026613,
       0.07960424450132775},
    zxy:
      {0.9372468582005039, 0.2308130859876117, 0.1995657251688989,
       0.168722160571667},
    zyx:
      {0.9489794544309479, 0.2308130859876117, 0.1995657251688989,
       0.07960424450132775},
    yzx:
      {0.9372468582005039, 0.2745997312243201, 0.1995657251688989,
       0.07960424450132775},
    xzy:
      {0.9489794544309479, 0.2308130859876117, 0.13302686547026613,
       0.168722160571667}
  }

  Enum.each(@computed, fn {representation, {w, x, y, z}} ->
    test "convert #{representation} Euler into Quaternion" do
      euler = Euler.init(unquote(representation), @deg_30, @deg_20, @deg_15)

      q0 =
        Quaternion.init(
          Radian.init(unquote(w)),
          unquote(x),
          unquote(y),
          unquote(z)
        )

      q1 = to_quaternion(euler)
      assert q0 == q1
    end
  end)
end
