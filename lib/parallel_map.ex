defmodule ParallelMap do
  @moduledoc """
  Contiene la funcionalidad de map en paralelo
  """
  @doc """
  aplica sobre cada elemento del iterable
  la función fun utilizando procesos diferentes
  y manteniendo el orden

  ##Ejemplo
      iex>ParallelMap.pmap(1..5,&(&1*&1))
      [1, 4, 9, 16, 25]
  """
  def pmap(iterable, fun) do
    me = self()
    iterable
    |> Enum.map(&spawn_link(fn -> send(me, {self(), fun.(&1)}) end))
    |> Enum.map(&receive do {^&1, result} -> result end)
  end
end
