defmodule Annex.Experimental.Math.ListOfList do
  def matrix_from_string(string, conversion \\ &line_to_float_list/1) do
    string
    |> String.trim
    |> String.split("\n")
    |> Enum.map(conversion)
    |> matrix_transpose
  end

  def vector_from_string(string, conversion \\ &line_to_float/1) do
    if string =~ "\n" do
      vector_from_string(string, "\n", conversion)
    else
      vector_from_string(string, ",", conversion)
    end
  end

  defp vector_from_string(string, splitter, conversion) do
    string
    |> String.trim
    |> String.split(splitter)
    |> Enum.map(conversion)
  end

  defp line_to_float_list(line) do
    line |> String.split |> Enum.map(&String.to_float/1)
  end

  defp line_to_float(line) do
    line |> String.trim |> String.to_float
  end

  def matrix_transpose(list_of_lists, list_so_far \\ [])
  def matrix_transpose([], rest), do: Enum.map(rest, &Enum.reverse/1)
  def matrix_transpose([first | rest], []) do
    matrix_transpose(rest, Enum.map(first, &[&1]))
  end
  def matrix_transpose([next | rest], so_far) do
    this_row = next
    |> Enum.zip(so_far)
    |> Enum.map(fn {entry, column} -> [entry | column] end)

    matrix_transpose(rest, this_row)
  end

  def dimensions_of!(list_of_list) when is_list(list_of_list) do
    this_dimension = length(list_of_list)
    [sample | rest] = Enum.map(list_of_list, &dimensions_of!/1)
    Enum.all?(rest, &(&1 == sample)) || throw "dimension mismatch"
    sample ++ [this_dimension]
  end
  def dimensions_of!(_), do: []
end
