defmodule AnnexTest.ListOfListTest do
  use ExUnit.Case

  alias Annex.Experimental.Math.ListOfList

  test "matrix transpose works" do
    assert [[1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]] ==
    ListOfList.matrix_transpose([[1, 4, 7],
                                 [2, 5, 8],
                                 [3, 6, 9]])
  end

  test "from_string works" do
    assert [[1.0, 2.0, 3.0],
            [4.0, 5.0, 6.0]] ==
    ListOfList.matrix_from_string(
    """
    1.0 4.0
    2.0 5.0
    3.0 6.0
    """
    )
  end
end
