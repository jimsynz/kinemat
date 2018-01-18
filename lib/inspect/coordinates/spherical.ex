defimpl Inspect, for: Kinemat.Coordinates.Spherical do
  import Inspect.Algebra

  @spec inspect(Angle.t(), any) :: String.t()
  def inspect(angle, opts) do
    angle =
      angle
      |> Map.from_struct()
      |> Enum.into([])

    concat(["#Kinemat.Point<", to_doc(angle, opts), ">"])
  end
end
