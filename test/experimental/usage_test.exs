defmodule AnnexTest.UsageTest do
  use ExUnit.Case
  use Annex.Experimental.Math

  alias Annex.Experimental.Layer
  alias Annex.Experimental.Layers.{Dense, Activation}

  test "basic xor training test" do
    # NB: this is still quite aspirational.
    flunk
  #  xor_layers = Layer.new(Dense, inputs: 2, outputs: 2, bias: true)
  #  |> Layer.new(Activation, function: :relu).()
  #  |> Layer.new(Dense, inputs: 2, outputs: 1).()
  #  |> Layer.new(Activation, function: :sigmoid).()
#
  #  dataset = ~M[1.0 1.0 0.0 0.0
  #               1.0 0.0 1.0 0.0]
  #  results = ~M[0.0 1.0 1.0 0.0]
  #  Layer.train(xor_layers, dataset, results)
  end

  test "basic xnor dummy test" do
    alias Annex.Experimental.Math.ElixirTensor, as: Tensor

    first_layer = Layer.new(
      Dense,
      inputs: 2, outputs: 2, bias: true,
      init: {~M[10.0 10.0
                -10.0 -10.0], ~V[-15.0, 5.0]})
    second_layer = Layer.new(Activation, function: :relu)
    third_layer = Layer.new(
      Dense,
      inputs: 2, outputs: 1, bias: true,
      init: {~M[10.0 10.0], ~V[-20.0]}
    )
    fourth_layer = Layer.new(Activation, function: :sigmoid)

    # lazy_evaluation
    full_stack = first_layer
    |> second_layer.()
    |> third_layer.()
    |> fourth_layer.()

    false_false = ~V[0.0, 0.0]
    assert %Tensor{data: [x]} = full_stack.(false_false)
    assert %Tensor{data: [^x]} = false_false
    |> first_layer.()
    |> second_layer.()
    |> third_layer.()
    |> fourth_layer.()
    assert x > 0.5

    true_false = ~V[1.0, 0.0]
    assert %Tensor{data: [x]} = full_stack.(true_false)
    assert %Tensor{data: [^x]} = true_false
    |> first_layer.()
    |> second_layer.()
    |> third_layer.()
    |> fourth_layer.()
    assert x < 0.5

    false_true = ~V[0.0, 1.0]
    assert %Tensor{data: [x]} = full_stack.(false_true)
    assert %Tensor{data: [^x]} = false_true
    |> first_layer.()
    |> second_layer.()
    |> third_layer.()
    |> fourth_layer.()
    assert x < 0.5

    true_true = ~V[1.0, 1.0]
    assert %Tensor{data: [x]} = full_stack.(true_true)
    assert %Tensor{data: [^x]} = true_true
    |> first_layer.()
    |> second_layer.()
    |> third_layer.()
    |> fourth_layer.()
    assert x > 0.5
  end
end
