defmodule Annex.SequenceXor2Test do
  use ExUnit.Case, async: true
  alias Annex
  alias Annex.Sequence

  test "xor test" do
    data = [
      [0.0, 0.0],
      [0.0, 1.0],
      [1.0, 0.0],
      [1.0, 1.0]
    ]

    labels = [
      [0.0, 1.0],
      [1.0, 0.0],
      [1.0, 0.0],
      [0.0, 1.0]
    ]

    seq1 =
      Annex.sequence(
        [
          Annex.dense(8, input_dims: 2),
          Annex.activation(:tanh),
          Annex.dense(2, input_dims: 8),
          Annex.activation(:sigmoid)
        ],
        learning_rate: 0.5
      )

    %Sequence{} =
      seq2 =
      Annex.train(seq1, data, labels, name: "xor2", epochs: 160_000, print_at_epoch: 10_000)

    [pred_yes, pred_no] = Annex.predict(seq2, [0.0, 0.0])
    assert_in_delta(pred_yes, 0.0, 0.1)
    assert_in_delta(pred_no, 1.0, 0.1)
    [pred_yes, pred_no] = Annex.predict(seq2, [0.0, 1.0])
    assert_in_delta(pred_yes, 1.0, 0.1)
    assert_in_delta(pred_no, 0.0, 0.1)
    [pred_yes, pred_no] = Annex.predict(seq2, [1.0, 0.0])
    assert_in_delta(pred_yes, 1.0, 0.1)
    assert_in_delta(pred_no, 0.0, 0.1)
    [pred_yes, pred_no] = Annex.predict(seq2, [1.0, 1.0])
    assert_in_delta(pred_yes, 0.0, 0.1)
    assert_in_delta(pred_no, 1.0, 0.1)
  end
end
