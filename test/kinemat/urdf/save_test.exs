defmodule Kinemat.URDF.SaveTest do
  use ExUnit.Case, async: true
  import Kinemat.URDF.{Load, Save}
  import KinematTest.FileHelpers

  describe "save/2" do
    test "it correctly serialises the \"visual\" Robot" do
      {:ok, robot} = load(fixture_path("urdf/visual.urdf"))

      with_test_directory(fn dir ->
        path = Path.join(dir, "visual.urdf")
        assert :ok = save(robot, path)

        assert {:ok, xml} = File.read(path)
        assert Regex.match?(~r/<robot name="visual"/, xml)
      end)
    end

    test "it correctly serialises the \"physics\" robot" do
      {:ok, robot} = load(fixture_path("urdf/physics.urdf"))

      with_test_directory(fn dir ->
        path = Path.join(dir, "physics.urdf")
        assert :ok = save(robot, path)

        assert {:ok, xml} = File.read(path)
        assert Regex.match?(~r/<robot name="physics"/, xml)
      end)
    end
  end

  defp with_test_directory(callback) when is_function(callback, 1) do
    path =
      System.tmp_dir!()
      |> Path.join(UUID.uuid1())

    File.mkdir_p!(path)

    callback.(path)

    File.rm_rf!(path)
  end
end
