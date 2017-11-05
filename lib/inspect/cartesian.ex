defimpl Inspect, for: Kinemat.Cartesian do
  alias Kinemat.Cartesian
  import Inspect.Algebra

  @spec inspect(Cartesian.t, any) :: String.t
  def inspect(angle, opts) do
    angle = angle
      |> Map.from_struct
      |> Enum.into([])
    concat ["#Kinemat.Point<", to_doc(angle, opts), ">"]
  end
end
