defmodule AnnexTest.BasicMathTest do
  use ExUnit.Case

  use Annex.Experimental.Math

  test "addition on vectors" do
    v1 = [1.0, 2.0, 3.0]
    v2 = [3.0, 4.0, 5.0]

    assert v1 + v2 == [4.0, 6.0, 8.0]
  end

  test "sigil_m generates a list-of-lists matrix" do
    assert [[1.0, 2.0, 4.0], [4.0, 3.0, 5.0]]
      = ~m[1.0 4.0
           2.0 3.0
           4.0 5.0]
  end

  test "multiplication of vectors" do
    matrix = ~m[1.0 2.0 3.0
                4.0 5.0 6.0]
    vector = [1.0, 2.0, 3.0]
    assert [14.0, 32.0] == matrix * vector
  end

  test "sigil_v generates a list_of_lists vector" do
    assert [1.0, 2.0, 4.0] == ~v[1.0, 2.0, 4.0]
    assert [1.0, 2.0, 4.0] == ~v[1.0
                                 2.0
                                 4.0]
  end

  test "matrix matrix multiplication" do
    matrix1 = ~m[1.0 2.0 3.0
                 4.0 5.0 6.0]
    matrix2 = ~m[1.0 2.0
                 3.0 4.0
                 5.0 6.0]
    matrix3 = ~m[22.0  28.0
                 49.0  64.0]
    assert matrix3 == matrix1 * matrix2
  end
end
