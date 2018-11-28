defmodule KinematMatrixNifTest do
  use ExUnit.Case
  import Kinemat.MatrixNif
  alias Kinemat.Matrix.{Matrix2, Matrix3, Matrix4}
  alias Kinemat.Vector.{Vector1, Vector2, Vector3, Vector4}
  doctest Kinemat.MatrixNif
end
