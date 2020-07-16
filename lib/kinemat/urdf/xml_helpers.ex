defmodule Kinemat.URDF.XmlHelpers do
  @moduledoc """
  Helpers for dealing with xmerl's terrible API.
  """

  require Record

  Record.defrecord(
    :xmlElement,
    Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  )

  Record.defrecord(
    :xmlText,
    Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")
  )

  Record.defrecord(
    :xmlAttribute,
    Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")
  )

  defguard is_element(node) when elem(node, 0) == :xmlElement
  defguard is_attribute(node) when elem(node, 1) == :xmlAttribute
  defguard is_text(node) when elem(node, 2) == :xmlText

  @doc """
  Retrieve the name of an XML element or attribute.
  """
  def get_name(node) when is_element(node), do: {:ok, encode_value(xmlElement(node, :name))}
  def get_name(node) when is_attribute(node), do: {:ok, encode_value(xmlAttribute(node, :name))}
  def get_name(_node), do: {:error, "Node has no name"}

  @doc """
  Returns the value of an XML attribute.
  """
  def get_value(node) when is_attribute(node), do: {:ok, encode_value(xmlAttribute(node, :value))}
  def get_value(_node), do: {:error, "Node is not an attribute"}

  @doc """
  Returns the value of a named XML attribute on an element.
  """
  def get_attribute_value(node, name) when is_element(node) and is_atom(name) do
    value =
      node
      |> xmlElement(:attributes)
      |> Enum.find_value(&(xmlAttribute(&1, :name) == name && xmlAttribute(&1, :value)))
      |> encode_value()

    if value, do: {:ok, value}, else: {:error, "Attribute not found"}
  end

  @doc """
  Returns all the child nodes of an XML element (including text, etc).
  """
  def get_content(node) when is_element(node), do: {:ok, xmlElement(node, :content)}
  def get_content(_node), do: {:error, "Node is not an element"}

  @doc """
  Return all the text contents of the element, if any.
  """
  def get_text(node) when is_element(node) do
    with contents <- xmlElement(node, :content),
         text_nodes <- Enum.map(contents, &xmlText(&1, :value)),
         result <- Enum.join(text_nodes, ""),
         do: {:ok, result}
  end

  def get_text(_node), do: {:error, "Node is not an element"}

  @doc """
  Returns all the child elements of an XML element.
  """
  def get_children(node) when is_element(node) do
    content =
      node
      |> xmlElement(:content)
      |> Enum.filter(&is_element(&1))

    {:ok, content}
  end

  def get_children(_node), do: {:error, "Node is not an element"}

  @doc """
  Returns true of the node is an element which has an attribute with the
  specified name.
  """
  def has_attribute?(node, attribute_name) when is_element(node) and is_atom(attribute_name) do
    node
    |> get_content()
    |> Enum.any?(fn
      child when is_attribute(child) ->
        case get_name(child) do
          {:ok, ^attribute_name} -> true
          _ -> false
        end

      _ ->
        false
    end)
  end

  @doc """
  A `map` which continues as long as the transformation function continues to
  return an `:ok` tuple.
  """
  def map_oks(enumerable, fun) do
    Enum.reduce_while(enumerable, {:ok, []}, fn item, {:ok, acc} ->
      case fun.(item) do
        {:ok, value} -> {:cont, {:ok, [value | acc]}}
        {:error, reason} -> {:halt, {:error, reason}}
      end
    end)
  end

  @doc """
  A `reduce` which continues as long as the transformation function continues
  return an `:ok` tuple.
  """
  def reduce_oks(enumerable, default, fun) do
    Enum.reduce_while(enumerable, {:ok, default}, fn item, {:ok, acc} ->
      case fun.(item, acc) do
        {:ok, value} -> {:cont, {:ok, value}}
        {:error, reason} -> {:halt, {:error, reason}}
      end
    end)
  end

  defp encode_value(value) when is_list(value), do: List.to_string(value)
  defp encode_value(value), do: value
end
