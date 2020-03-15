defmodule Fuel do
  @moduledoc """
  Day 1 problem in `Advent of Code`.
  """

  def calculate_fuel do
    Reader.readdata("d1")
    |> String.split("\r\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&(div(&1, 3) - 2))
    |> Enum.reduce(fn x, acc -> x + acc end)
  end

  def calculate_total_fuel do
    Reader.readdata("d1")
    |> String.split("\r\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&(fuel_requirement(&1)))
    |> Enum.reduce(fn x, acc -> x + acc end)
  end

  def fuel_requirement(mass) do
    (div(mass, 3) - 2)
     |> fuel_req()
  end

  defp fuel_req(0), do: 0
  defp fuel_req(x) when x < 0, do: 0
  defp fuel_req(x) do 
    x + fuel_req(div(x, 3) - 2)
  end

end
