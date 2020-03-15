defmodule Fuel do
  @moduledoc """
  Day 1 problem in `Advent of Code`.
  """

  def calculate do
    Reader.readdata("d1")
    |> String.split("\r\n")
    |> Enum.map(fn x -> process(x) end)
    |> Enum.reduce(fn x, acc -> x + acc end)
  end

  defp process(num_string) do
    {num, _} = Integer.parse(num_string)
    div(num, 3) - 2
  end
end
