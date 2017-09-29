defmodule PocOverheadTest do
  use ExUnit.Case
  doctest PocOverhead
  test "crea 10 hilos" do
    {tiempo, n} = PocOverhead.run(10)
    assert n == 10
  end
end
