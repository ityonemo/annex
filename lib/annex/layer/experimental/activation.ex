defmodule Annex.Experimental.Layers.Activation do

  use Annex.Experimental.Math

  alias Annex.Experimental.Math.ElixirTensor

  @behaviour Annex.Experimental.Layer

  # NB: activation layers typically don't have to store any data.

  @spec init(keyword) :: nil | Math.tensor
  def init(_options), do: nil

  @spec eval(nil, Math.tensor, keyword) :: Math.tensor
  def eval(nil, input, function: :relu), do: Math.relu(input)
  def eval(nil, input, function: :sigmoid), do: Math.sigmoid(input)
  def eval(nil, input, function: :softmax), do: Math.softmax(input)

end
