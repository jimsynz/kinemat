defmodule Kinemat.Matrix do
  alias Kinemat.Matrix.{Matrix2, Matrix3, Matrix4}
  @moduledoc false

  @type t :: Matrix2.t() | Matrix3.t() | Matrix4.t()
end
