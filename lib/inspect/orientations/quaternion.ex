defimpl Inspect, for: Kinemat.Orientations.Quaternion do
  alias Kinemat.Orientation
  use Kinemat.Orientations
  import Inspect.Algebra

  @spec inspect(Orientation.t(), any) :: String.t()
  def inspect(%Quaternion{w: w, x: x, y: y, z: z}, opts) do
    values = [type: :quaternion, w: w, x: x, y: y, z: z]
    concat(["#Kinemat.Orientation<", to_doc(values, opts), ">"])
  end
end
