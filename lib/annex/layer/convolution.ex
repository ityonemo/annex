defmodule Annex.Layer.Convolution do
  @moduledoc """
  Best used for learning patterns in which data is expressable in 2D (e.g.
  photos, 1D data in a time-series) and in which data points are spatially
  related (even latently).

  `filters` is a list of `Data.data()` that are the convolving data structures.
  """

  use Annex.Debug, debug: true

  alias Annex.{
    Data,
    Data.DMatrix,
    Data.Shape,
    Layer,
    Layer.Convolution
  }

  use Layer

  defp configured_data_type do
    :annex
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:data_type, DMatrix)
  end

  @type t :: %Convolution{
          input_shape: Shape.t(),
          filters: [Data.data(), ...],
          stride: Shape.t(),
          data_type: Data.type()
        }

  defstruct data_type: nil,
            filters: nil,
            stride: nil,
            input_shape: nil

  def filters(%Convolution{filters: filters}), do: filters

  def stride(%Convolution{stride: stride}), do: stride

  def input_width(%Convolution{} = conv) do
    case input_shape(conv) do
      {width} -> width
      {_rows, columns} -> columns
    end
  end

  def filter_width(%Convolution{} = conv) do
    case filter_shape(conv) do
      [width] -> width
      [_, columns] -> columns
    end
  end

  @spec output_width(t()) :: pos_integer()
  def output_width(%Convolution{} = conv) do
    input_width(conv) - filter_width(conv) + 1
  end

  @spec depth(t()) :: non_neg_integer
  def depth(%Convolution{} = conv), do: conv |> filters() |> length

  def filter_shape(%Convolution{} = conv) do
    conv
    |> filters()
    |> hd()
    |> Data.shape()
  end

  @impl Layer
  def init_layer(%LayerConfig{} = cfg) do
    with(
      {:ok, :data_type, data_type} <- LayerConfig.fetch(cfg, :data_type)

      # :filters: nil,
      #   :stride: nil,
      #   :input_shape: nil
    ) do
      raise "not implemented"
    else
      {:error, _, %AnnexError{} = err} ->
        raise err
    end
  end

  def init_filters(%LayerConfig{} = cfg) do
    with(
      {:error, _, _} <- LayerConfig.fetch(cfg, :filters),
      {:error, _, _} <- LayerConfig.fetch(cfg, :n_filters)
      # add more stuff
    ) do
      raise "not implemented"
    else
      {:ok, :filters, _filters} ->
        raise "not implemented"

      {:ok, :n_filters, _n_filters} ->
        raise "not implemented"
    end
  end

  @impl Layer
  def backprop(%Convolution{} = _conv, _error, _backprops) do
    raise "not implemented"
  end

  @impl Layer
  def feedforward(%Convolution{} = _conv, _inputs) do
    raise "not implemented"
  end

  @impl Layer
  def data_type(%Convolution{data_type: data_type}) do
    data_type
  end

  @impl Layer
  # @spec shapes(t()) :: {Shape.t(), Shape.t()}
  def shapes(%Convolution{} = conv), do: {input_shape(conv), output_shape(conv)}

  @spec input_shape(t()) :: Shape.t()
  def input_shape(%Convolution{input_shape: input_shape}), do: input_shape

  @spec output_shape(t()) :: Shape.t()
  def output_shape(%Convolution{} = conv) do
    case input_shape(conv) do
      [_] -> [output_width(conv), depth(conv)]
      [rows, _] -> [rows, output_width(conv), depth(conv)]
    end
  end
end
