defprotocol Kinemat.Vector do
  alias Kinemat.Vector.{Vector1, Vector2, Vector3, Vector4}

  @type t :: Vector1.t() | Vector2.t() | Vector3.t() | Vector4.t()

  @moduledoc false

  @doc """
  Truncate a vector by dropping it's last digit.
  """
  @spec truncate(t) :: {:ok, t()} | {:error, term}
  def truncate(_vector)

  @doc """
  Truncate a vector by dropping it's `n`th element.
  """
  @spec truncate_n(t(), non_neg_integer) :: {:ok, t()} | {:error, term}
  def truncate_n(_vector, _n)

  @doc """
  Add two vectors together.
  """
  @spec add(t, t) :: {:ok, t} | {:error, term}
  def add(_lhs, _rhs)
end
