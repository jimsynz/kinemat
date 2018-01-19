defimpl Inspect, for: Kinemat.Orientations.RotationMatrix do
  alias Kinemat.Orientation
  use Kinemat.Orientations
  import Inspect.Algebra

  @spec inspect(Orientation.t(), any) :: String.t()
  def inspect(
        %RotationMatrix{matrix: {m00, m01, m02, m10, m11, m12, m20, m21, m22}},
        opts
      ) do
    concat([
      "#Kinemat.Orientation<",
      to_doc(
        [
          rotation_matrix: {{m00, m01, m02}, {m10, m11, m12}, {m20, m21, m22}}
        ],
        opts
      ),
      ">"
    ])
  end
end
