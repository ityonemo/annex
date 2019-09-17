defprotocol Annex.Experimental.Mathable do
  @doc "performs addition"
  def a + b
  #@doc "performs subtraction"
  #def a - b
  @doc "performs tensor products"
  def a * b
  #@doc "performs outer products"
  #def a <> b
  def relu(v)
  def sigmoid(v)
  def softmax(v)
end

defimpl Annex.Experimental.Mathable, for: List do

  alias Annex.Experimental.Mathable

  import Kernel, except: [+: 2, *: 2]
  def a + b do
    a
    |> Enum.zip(b)
    |> Enum.map(fn {a, b} ->
      Annex.Experimental.Mathable.+(a, b)
    end)
  end

  def a * b when is_number(b) do
    Enum.map(a, &Mathable.*(&1, b))
  end
  def a * (b = [sample | _]) when is_number(sample) do
    a
    |> Enum.zip(b)
    |> Enum.map(fn {a, b} -> Mathable.*(a, b) end)
    |> Enum.reduce(&Mathable.+/2)
  end
  def a * b when is_list(b) do
    Enum.map(b, &Mathable.*(a, &1))
  end

  def relu(lst), do: Enum.map(lst, &Mathable.relu(&1))
  def sigmoid(lst), do: Enum.map(lst, &Mathable.sigmoid(&1))
  def softmax(lst = [sample | _]) when is_number(sample) do
    softsum = Enum.reduce(0.0, fn v, tot -> tot + :math.exp(v) end)
    Enum.map(lst, &(:math.exp(&1) / softsum))
  end
  def softmax(lst), do: Enum.map(lst, &Mathable.softmax(&1))
end

defimpl Annex.Experimental.Mathable, for: Integer do
  import Kernel, except: [+: 2, *: 2]
  def a + b, do: Kernel.+(a, b)
  def a * b when is_number(b), do: Kernel.*(a, b)
  def a * b when is_list(b) do
    Enum.map(b, &(a * &1))
  end
  def relu(x) when x > 0, do: x
  def sigmoid(_), do: raise("error, can't sigmoid an integer.")
  def softmax(_), do: raise("error, can't softmax an integer.")
end

defimpl Annex.Experimental.Mathable, for: Float do
  import Kernel, except: [+: 2, *: 2]
  def a + b, do: Kernel.+(a, b)

  def a * b when is_number(b), do: Kernel.*(a, b)
  def a * b when is_list(b) do
    Enum.map(b, &(a * &1))
  end

  def relu(x) when x > 0.0, do: x
  def relu(_), do: 0.0

  def sigmoid(x), do: 1.0 / (1.0 + :math.exp(-x))

  def softmax(_), do: raise("error, can't softmax a non-tensor")
end

defimpl Annex.Experimental.Mathable, for: Atom do
  import Kernel, except: [+: 2, *: 2]
  def nil + lst when is_list(lst), do: lst
  def _ * _, do: raise("error, can't multiply by atom.")
  def relu(_), do: raise("error, can't relu an atom.")
  def sigmoid(_), do: raise("error, can't sigmoid an atom.")
  def softmax(_), do: raise("error, can't softmax an atom.")
end
