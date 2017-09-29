defmodule PocOverhead do
  @moduledoc """
  La única finalidad de este módulo es
  ser capaz de lanzar una serie de procesos
  para ver como varía el tiempo de ejecución
  en función de estos y así tener una idea
  aproximada de la capacidad de gestión de
  procesos
  """

  @doc """
  se pone a la escucha y cuando le llega
  un mensaje con un entero pasa al proceso
  de next_pid el entero más 1
  """
  def counter(next_pid) do
    receive do
      n -> send(next_pid, n + 1)
    end
  end

  @doc """
  Crea n procesos, que se ponen a la escucha
  y envía el mensaje al ultimo proceso creado
  para desencadenar la llamada al resto de procesos

  """
  def create_processes(n) do
    last = Enum.reduce(
      1..n,
      self(),
      fn(_, send_to) ->
        spawn(PocOverhead, :counter, [send_to])
      end
    )
    send(last, 0)

    receive do
      final_answer when is_integer(final_answer) ->
        final_answer
    end
  end

  def run(n) do
    result = :timer.tc(PocOverhead, :create_processes, [n])
    "#{inspect result}" |> IO.puts
    result
  end
end
