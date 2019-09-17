defmodule Annex.Experimental.Layers.Multi do
  alias Annex.Experimental.Layer

  @spec append(Layer.layerfunction, term, module, keyword) :: Layer.layerfunction
  def append(lazy, data, module, options) do
    # generate a new function from data/module/options
    this_layer = Layer.encapsulate(data, module, options)

    #check to see if we are in a chain
    if __MODULE__ == lazy.(:module) do
      # we already are a lazy module.
      new_data = lazy.(:data) ++ [data]

      Layer.encapsulate(
        new_data, __MODULE__,
        layers: (Keyword.get(lazy.(:options), :layers) ++ [this_layer]))
    else
      # return an encapsulation of the current module.
      compound_data = [lazy.(:data), data]
      Layer.encapsulate(compound_data, __MODULE__, layers: [lazy, this_layer])
    end
  end

  @doc """
  iteratively applies all of the layers to the input.
  """
  @spec eval(any, Math.tensor, keyword) :: Math.tensor
  def eval(_data, input, layers: layers) do
    Enum.reduce(layers, input, &(&1.(&2)))
  end
end
