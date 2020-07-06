defmodule Kinemat.Robot.Limit do
  defstruct effort: nil, lower: nil, upper: nil, velocity: nil
  alias Kinemat.Robot.Limit

  @moduledoc """
  Encapsulates the limits of a joint.
  """

  @type t :: %Limit{
          effort: number | nil,
          lower: number | nil,
          upper: number | nil,
          velocity: number | nil
        }

  @type options :: [option]
  @type option :: {:effort | :lower | :upper | :velocity, number | nil}

  @doc """
  Initialise a new effort container with the provided values.
  """
  @spec init(options) :: Limit.t()
  def init(options) when is_list(options) do
    fields =
      options
      |> Keyword.take(~w[effort lower upper velocity]a)
      |> Enum.into(%{})

    struct(Limit, fields)
  end
end
