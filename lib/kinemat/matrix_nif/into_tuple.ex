defprotocol Kinemat.MatrixNif.IntoTuple do
  @doc """
  Convert into a tuple for passing into our NIFs.
  """
  def into(_data_type)
end
