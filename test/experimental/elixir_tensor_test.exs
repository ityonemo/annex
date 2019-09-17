defmodule AnnexTest.ElixirTensorTest do
  use ExUnit.Case
  use Annex.Experimental.Math

  alias Annex.Experimental.Math.ElixirTensor

  test "concat_dims/2" do
    assert [2] == ElixirTensor.concat_dims([3], [3, 2])
    assert [3, 2] == ElixirTensor.concat_dims([3, 3], [3, 2])
    assert [1] == ElixirTensor.concat_dims([1, 3], [3])
    assert [2, 4, 6] == ElixirTensor.concat_dims([2, 4, 10], [10, 6])
  end

  test "sigil_M generates a tensor from a matrix" do
    assert %{data: [[1.0, 2.0, 4.0], [4.0, 3.0, 5.0]]}
      = ~M[1.0 4.0
           2.0 3.0
           4.0 5.0]
  end

  test "we can do matrix multiplication as we expect" do
    matrix1 = ~M[1.0 2.0 3.0
                   4.0 5.0 6.0]
    matrix2 = ~M[1.0 2.0
                   3.0 4.0
                   5.0 6.0]
    matrix3 = ~M[22.0  28.0
                   49.0  64.0]
    assert matrix3 == matrix1 * matrix2
  end
end
