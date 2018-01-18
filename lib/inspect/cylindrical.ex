defimpl Inspect, for: Kinemat.Cylindrical do
  alias Kinemat.Cylindrical
  import Inspect.Algebra

  @spec inspect(Cylindrical.t(), any) :: String.t()
  def inspect(angle, opts) do
    angle =
      angle
      |> Map.from_struct()
      |> Enum.into([])

    concat(["#Kinemat.Point<", to_doc(angle, opts), ">"])
  end
end
