defmodule ParallelMapTest do
  use ExUnit.Case
  doctest ParallelMap

  test "map [3,4] == [9,16] " do
    assert ParallelMap.pmap([3,4], &(&1*&1)) == [9,16]
  end
end
