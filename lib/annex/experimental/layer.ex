defmodule Annex.Experimental.Layer do

  @type layerinput :: struct() | :data | :options
  @type layeroutput :: struct()
  @type layerfunction :: (layerinput -> layeroutput)

  alias Annex.Experimental.Layers.Multi

  @spec new(module, keyword) :: layerfunction
  def new(layer_module, options) do
    options
    |> layer_module.init()
    |> encapsulate(layer_module, options)
  end

  @spec encapsulate(any, module, keyword) :: layerfunction
  def encapsulate(data, layer_module, options) do
    fn
      input = %_tensor_module{} -> layer_module.eval(data, input, options)
      lazy when is_function(lazy, 1) ->
        Multi.append(lazy, data, layer_module, options)
      :data -> data
      :module -> layer_module
      :options -> options
    end
  end

  @spec pickle(layerfunction) :: binary
  def pickle(fun), do: :erlang.term_to_binary(fun)

  @spec hydrate(binary) :: layerfunction
  def hydrate(binary), do: :erlang.binary_to_term(binary)
end
