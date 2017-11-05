defimpl Inspect, for: Kinemat.Quaternion do
  alias Kinemat.{Quaternion, Orientation}
  import Inspect.Algebra

  @spec inspect(Orientation.t, any) :: String.t
  def inspect(%Quaternion{w: w, x: x, y: y, z: z}, opts) do
    values = [type: :quaternion, w: w, x: x, y: y, z: z]
    concat ["#Kinemat.Orientation<", to_doc(values, opts), ">"]
  end
end
