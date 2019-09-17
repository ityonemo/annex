defmodule Annex.Experimental.Math.ElixirTensor do
  defstruct dims: [],
            data: []

  alias Annex.Experimental.Math.ListOfList

  @type dims :: [integer]
  @type data :: [integer] | [data]

  @type t :: %__MODULE__{dims: dims, data: data}

  @spec new(data) :: t
  def new(lst) when is_list(lst) do
    # ascertain the dimensions.
    %__MODULE__{dims: ListOfList.dimensions_of!(lst), data: lst}
  end

  @spec new(data, dims) :: t
  def new(lst, dims) do
    %__MODULE__{dims: dims, data: lst}
  end

  @spec concat_dims(dims, dims) :: dims
  def concat_dims([a], [a | rest]), do: rest
  def concat_dims([a | rest], b), do: concat_dims([a], rest, b)
  @spec concat_dims(dims, dims, dims) :: dims
  def concat_dims(pre, [a], [a | post]), do: pre ++ post
  def concat_dims(pre, [a | rest], b), do: concat_dims(pre ++ [a], rest, b)

  defmacro sigil_M({:<<>>, _meta, [str]}, []) do
    alias Annex.Experimental.Math.ListOfList

    tensor = ListOfList.matrix_from_string(str)
    dims = ListOfList.dimensions_of!(tensor)
    quote do
      %Annex.Experimental.Math.ElixirTensor{
        data: unquote(tensor),
        dims: unquote(dims)
      }
    end
  end

  defmacro sigil_V({:<<>>, _meta, [str]}, []) do
    alias Annex.Experimental.Math.ListOfList

    vector = ListOfList.vector_from_string(str)
    dims = [length(vector)]
    quote do
      %Annex.Experimental.Math.ElixirTensor{
        data: unquote(vector),
        dims: unquote(dims)
      }
    end
  end

  defimpl Annex.Experimental.Mathable do
    alias Annex.Experimental.Math.ElixirTensor
    alias Annex.Experimental.Math

    def (a = %{dims: d}) + (b = %ElixirTensor{dims: d}) do
      a.data
      |> Math.+(b.data)
      |> ElixirTensor.new(d)
    end

    @spec ElixirTensor.t * ElixirTensor.t :: ElixirTensor.t
    def a * b do
      unless List.first(b.dims) == List.last(a.dims), do: throw("mismatched dimensions")
      a.data
      |> Math.*(b.data)
      |> ElixirTensor.new(ElixirTensor.concat_dims(a.dims, b.dims))
    end

    @spec relu(ElixirTensor.t) :: ElixirTensor.t
    def relu(input), do: %ElixirTensor{input | data: Math.relu(input.data)}

    @spec sigmoid(ElixirTesor.t) :: ElixirTensor.t
    def sigmoid(input), do: %ElixirTensor{input | data: Math.sigmoid(input.data)}

    @spec softmax(ElixirTesor.t) :: ElixirTensor.t
    def softmax(input), do: %ElixirTensor{input | data: Math.softmax(input.data)}
  end
end

