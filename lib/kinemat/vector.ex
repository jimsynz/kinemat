defmodule Kinemat.Vector do
  alias Kinemat.Vector.{Vector1, Vector2, Vector3, Vector4}

  @type t :: Vector1.t() | Vector2.t() | Vector3.t() | Vector4.t()
end
