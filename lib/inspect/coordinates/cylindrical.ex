defimpl Inspect, for: Kinemat.Coordinates.Cylindrical do
  alias Kinemat.Coordinates.Cylindrical
  import Inspect.Algebra

  @spec inspect(Cylindrical.t(), any) :: String.t()
  def inspect(angle, opts) do
    angle =
      angle
      |> Map.from_struct()
      |> Enum.sort_by(&elem(&1, 0))
      |> Enum.into([])

    concat(["#Kinemat.Point<", to_doc(angle, opts), ">"])
  end
end
