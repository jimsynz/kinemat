defmodule Kinemat.URDF.Load do
  alias Kinemat.URDF.Parser

  @moduledoc """
  This module parses URDF XML files and strings.
  """

  @doc """
  Attempt to load and parse a URDF XML file.
  """
  @spec load(Path.t()) :: {:ok, Robot.t()} | {:error, any}
  def load(path) do
    with {node, []} <- :xmerl_scan.file(path), do: Parser.parse(node)
  end

  @doc """
  Attempt to parse a URDF XML string.
  """
  def parse(xml) do
    with xml <- String.to_charlist(xml),
         {node, []} <- :xmerl_scan.string(xml),
         do: Parser.parse(node)
  end
end
