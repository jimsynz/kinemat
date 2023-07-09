defimpl Inspect, for: Kinemat.Coordinates.Cartesian do
  alias Kinemat.Coordinates.Cartesian
  import Inspect.Algebra

  @spec inspect(Cartesian.t(), any) :: String.t()
  def inspect(angle, opts) do
    angle =
      angle
      |> Map.from_struct()
      |> Enum.sort_by(&elem(&1, 0))
      |> Enum.into([])

    concat(["#Kinemat.Point<", to_doc(angle, opts), ">"])
  end
end
