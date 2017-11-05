defimpl Inspect, for: Kinemat.Frame do
  alias Kinemat.Frame
  import Inspect.Algebra

  @spec inspect(Frame.t, any) :: String.t
  def inspect(plane, opts) do
    plane = plane
      |> Map.from_struct
      |> Enum.into([])
    concat ["#Kinemat.Frame<", to_doc(plane, opts), ">"]
  end
end
