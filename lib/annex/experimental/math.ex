defmodule Annex.Experimental.Math do
  # when you "use" math, you disable some kernel calls
  # and replace them with annex calls.
  defmacro __using__(_) do
    quote do
      import Kernel, except: [+: 2, *: 2] #, -: 2, <>: 2]
      import Annex.Experimental.Math, only: [+: 2, *: 2, sigil_m: 2, sigil_v: 2] #, -: 2, <>: 2]
      import Annex.Experimental.Math.ElixirTensor, only: [sigil_M: 2, sigil_V: 2]

      alias Annex.Experimental.Math
    end
  end

  alias Annex.Experimental.Math.ListOfList

  @type tensor :: %{
    required(:__struct__) => module,
    required(:dims) => [integer],
    required(:data) => any
  }

  defmacro sigil_m({:<<>>, _meta, [str]}, []) do
    matrix = ListOfList.matrix_from_string(str)
    quote do unquote(matrix) end
  end

  defmacro sigil_v({:<<>>, _meta, [str]}, []) do
    vector = ListOfList.vector_from_string(str)
    quote do unquote(vector) end
  end

  def a + b, do: Annex.Experimental.Mathable.+(a, b)

  #def a-b when is_struct(a) and is_struct(b) do
  #  a.__struct__.-(a, b)
  #end
  #def a-b, do: Kernel.-(a, b)
#
  def a * b, do: Annex.Experimental.Mathable.*(a, b)
#
  #def a<>b when is_struct(a) and is_struct(b) do
  #  a.__struct__.<>(a, b)
  #end
  #def a<>b, do: Kernel.*(a, b)

  @spec relu(list) :: list
  @spec relu(number) :: number
  @spec relu(tensor) :: tensor
  def relu(v), do: Annex.Experimental.Mathable.relu(v)

  @spec sigmoid(list) :: list
  @spec sigmoid(number) :: number
  @spec sigmoid(tensor) :: tensor
  def sigmoid(v), do: Annex.Experimental.Mathable.sigmoid(v)

  @spec softmax(list) :: list
  @spec softmax(number) :: number
  @spec softmax(tensor) :: tensor
  def softmax(v), do: Annex.Experimental.Mathable.softmax(v)
end
