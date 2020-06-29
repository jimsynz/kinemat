defmodule KinematTest.FileHelpers do
  @moduledoc """
  Test support module for finding fixtures.
  """

  def fixture_path(filename) do
    :kinemat
    |> :code.priv_dir()
    |> Path.join("fixtures")
    |> Path.join(filename)
  end

  def with_temporary_dir(callback) when is_function(callback, 1) do
    path =
      System.tmp_dir!()
      |> Path.join(UUID.uuid1())

    File.mkdir_p!(path)

    callback.(path)

    File.rm_rf!(path)
  end
end
