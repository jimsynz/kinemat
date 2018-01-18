defimpl Inspect, for: Kinemat.Euler do
  alias Kinemat.{Euler, Orientation}
  import Inspect.Algebra

  @spec inspect(Orientation.t(), any) :: String.t()
  def inspect(%Euler{representation: r, x: x, y: y, z: z}, opts) do
    values = [euler: r, x: x, y: y, z: z]
    concat(["#Kinemat.Orientation<", to_doc(values, opts), ">"])
  end
end
