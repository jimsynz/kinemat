defmodule KinematMatrixNifFromTupleTest do
  use ExUnit.Case
  alias Kinemat.Matrix.{Matrix2, Matrix3, Matrix4}
  alias Kinemat.MatrixNif.FromTuple
  alias Kinemat.Vector.{Vector1, Vector2, Vector3, Vector4}
  doctest Kinemat.MatrixNif.FromTuple
end
