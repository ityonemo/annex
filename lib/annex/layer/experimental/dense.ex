defmodule Annex.Experimental.Layers.Dense do

  use Annex.Experimental.Math

  alias Annex.Experimental.Math.ElixirTensor

  @behaviour Annex.Experimental.Layer

  # TODO: use the actual better initialization procedure
  # which makes the weights depend on the matrix size.

  @spec init(keyword) :: Math.tensor
  def init(options) do
    outputs = Keyword.fetch!(options, :outputs)
    inputs = Keyword.fetch!(options, :inputs)

    if options[:bias] do
      init_bias(options, outputs, inputs)
    else
      init_unbias(options, outputs, inputs)
    end
  end

  def eval({linear = %_{dims: [outputs, inputs]},
            bias = %_{dims: [outputs]}},
            input = %_{dims: [inputs | _]},
            _options) do
    linear * input + bias
  end

  @spec eval(Math.tensor, Math.tensor, keyword) :: Math.tensor
  def eval(data = %_{dims: [_, inputs]}, input = %_{dims: [inputs | _]}, _options) do
    data * input
  end

  # TODO: consider adding verification stuff here
  def init_bias(options, outputs, inputs) do
    options[:init] || {
      init_unbias(options, outputs, inputs),
      1..outputs
      |> Enum.map(fn _ -> :rand.normal() end)
      |> ElixirTensor.new([outputs])
    }
  end

  def init_unbias(options, outputs, inputs) do
    options[:init] ||
      (Enum.map(1..inputs, fn _ ->
        Enum.map(1..outputs, fn _ ->
          :rand.normal()
        end)
      end)
      |> ElixirTensor.new([outputs, inputs]))
  end

end
