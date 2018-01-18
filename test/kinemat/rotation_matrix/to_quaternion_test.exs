defmodule Kinemat.RotationMatrixToQuaternionTest do
  use ExUnit.Case
  use Kinemat
  doctest Kinemat.RotationMatrix.ToQuaternion

  @rotation RotationMatrix.init({0, 1, 0, 1, 0, 0, 0, 0, -1})

  # This value calculated with the Mittsu Ruby gem.
  @correct Quaternion.init(
             ~a(0.0)r,
             0.7071067811865475,
             0.7071067811865476,
             0.0
           )

  test "convert rotation matrix to quaternion" do
    computed = RotationMatrix.ToQuaternion.to_quaternion(@rotation)
    assert computed == @correct
  end
end
