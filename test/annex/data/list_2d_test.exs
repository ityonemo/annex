defmodule Annex.Data.List2DTest do
  use Annex.DataCase

  alias Annex.{
    Data,
    Data.List2D
  }

  # @data_5 [1.0, 2.0, 3.0, 4.0, 5.0]

  # @data_6 [1.0, 1.0, 1.0, 2.0, 2.0, 2.0]

  # @data_8 [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]

  # @data_2_by_3 [
  #   [1.0, 1.0, 1.0],
  #   [2.0, 2.0, 2.0]
  # ]

  # @data_2_by_2_by_2 [
  #   [
  #     [1.0, 2.0],
  #     [3.0, 4.0]
  #   ],
  #   [
  #     [5.0, 6.0],
  #     [7.0, 8.0]
  #   ]
  # ]

  # @data_4_by_2 [
  #   [1.0, 2.0],
  #   [3.0, 4.0],
  #   [5.0, 6.0],
  #   [7.0, 8.0]
  # ]

  # describe "cast/2" do
  #   test "given a flat list and :defer returns a flat list" do
  #     assert List1D.cast([1.0, 1.0, 1.0, 2.0, 2.0, 2.0], :defer) == [1.0, 1.0, 1.0, 2.0, 2.0, 2.0]
  #   end

  #   test "works for a single dimension where the dimension is the count of the data items" do
  #     assert List1D.cast(@data_2_by_3, {6}) == [1.0, 1.0, 1.0, 2.0, 2.0, 2.0]
  #   end

  #   test "works for a two dimensions where the dimensions is the count of the data items" do
  #     assert List1D.cast(@data_2_by_3, {3, 2}) == [[1.0, 1.0], [1.0, 2.0], [2.0, 2.0]]
  #   end

  #   test "raises for empty dimensions {}" do
  #     assert_raise(Enum.EmptyError, fn ->
  #       ListType.cast(@data_2_by_3, {})
  #     end)
  #   end
  # end

  # describe "to_flat_list/1" do
  #   test "can handle flat lists" do
  #     flat_list = [1.0, 2.0, 3.0]
  #     assert ListType.to_flat_list(flat_list) == flat_list
  #   end

  #   test "can handle nested lists" do
  #     assert ListType.to_flat_list(@data_2_by_3) == [1.0, 1.0, 1.0, 2.0, 2.0, 2.0]
  #   end
  # end

  # describe "shape/1" do
  #   test "is correct for flat lists" do
  #     assert ListType.shape(@data_5) == {5}
  #   end

  #   test "is correctly ordered for nested lists" do
  #     assert ListType.shape(@data_2_by_3) == {2, 3}
  #   end
  # end

  # describe "is_type?/1" do
  #   test "is true for float containing nested list" do
  #     assert ListType.is_type?(@data_2_by_2_by_2) == true
  #   end

  #   test "is true for float containing flat lists" do
  #     assert ListType.is_type?(@data_5) == true
  #   end

  #   test "is false for non list of float containing types" do
  #     assert ListType.is_type?(:nope) == false
  #     assert ListType.is_type?([:nope]) == false
  #     assert ListType.is_type?([1]) == false
  #     assert ListType.is_type?([[1]]) == false
  #     assert ListType.is_type?(1) == false
  #     assert ListType.is_type?(1.0) == false
  #     assert ListType.is_type?("1.0") == false
  #     assert ListType.is_type?('1.0') == false
  #     assert ListType.is_type?(true) == false
  #     assert ListType.is_type?(false) == false
  #     assert ListType.is_type?(%URI{}) == false
  #     assert ListType.is_type?(%{}) == false
  #   end
  # end

  # describe "Data Behaviour" do
  #   test "shape/1 works" do
  #     [{@data_5, {5}}, {@data_2_by_3, {2, 3}}]
  #     |> Enum.each(fn {data, expected_shape} ->
  #       assert Data.shape(ListType, data) == expected_shape
  #     end)
  #   end

  #   test "cast/2 works" do
  #     [
  #       {@data_5, {5}, @data_5},
  #       {@data_2_by_3, {2, 3}, @data_2_by_3},
  #       {@data_8, {2, 2, 2}, @data_2_by_2_by_2},
  #       {@data_8, {4, 2}, @data_4_by_2}
  #     ]
  #     |> Enum.each(fn {data, shape_to_cast, expected} ->
  #       assert Data.cast(ListType, data, shape_to_cast) == expected
  #     end)
  #   end

  #   test "to_flat_list/1 works" do
  #     [
  #       {@data_5, @data_5},
  #       {@data_2_by_3, @data_6},
  #       {@data_6, @data_6},
  #       {@data_8, @data_8},
  #       {@data_2_by_2_by_2, @data_8},
  #       {@data_4_by_2, @data_8}
  #     ]
  #     |> Enum.each(fn {data, expected} ->
  #       assert Data.to_flat_list(ListType, data) == expected
  #     end)
  #   end
  # end
end
