defmodule Annex do
  alias Annex.{Sequence, Dense, Activation, Learner}
  require Logger

  def sequence(layers, opts \\ []) when is_list(layers) do
    Sequence.build([{:layers, layers} | opts])
  end

  def initialize(%module{} = layer) do
    module.initialize(layer)
  end

  def dense(rows, opts \\ []) do
    %Dense{
      rows: rows,
      cols: Keyword.get(opts, :input_dims),
      neurons: Keyword.get(opts, :data)
    }
  end

  def activation(name) do
    Activation.build(name)
  end

  @doc """
  Trains the given `Annex.Learner` given the `learner`, `data`, `labels`, and `options`.
  """
  def train(learner, data, labels, options \\ []) do
    Learner.train(learner, data, labels, options)
  end

  def predict(%Sequence{} = seq, data) do
    Sequence.predict(seq, data)
  end
end
