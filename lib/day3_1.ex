defmodule CrossedWires do

  @spec process_input :: [any]
  def process_input do
    Reader.read_data("d3")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end

  @spec get_direction_and_length(binary) :: {integer, any}
  def get_direction_and_length(<<direction::utf8>> <> length) do
    {direction, String.to_integer(length)}
  end

  @spec process_list(any) :: [any]
  def process_list(list) do
    Enum.map(list, fn x -> get_direction_and_length(x) end)
  end

  @spec process_instruction(any, any) :: any
  def process_instruction([{?R, length} | rest], data) do
    {x, y} = List.last(data)
    new_data = data ++ for n <- (x + 1)..(x + length), do: {n, y}
    process_instruction(rest, new_data)
  end

  def process_instruction([{?U, length} | rest], data) do
    {x, y} = List.last(data)
    new_data = data ++ for n <- (y + 1)..(y + length), do: {x, n}
    process_instruction(rest, new_data)
  end

  def process_instruction([{?L, length} | rest], data) do
    {x, y} = List.last(data)
    new_data = data ++ for n <- (x - 1)..(x - length), do: {n, y}
    process_instruction(rest, new_data)
  end

  def process_instruction([{?D, length} | rest], data) do
    {x, y} = List.last(data)
    new_data = data ++ for n <- (y - 1)..(y - length), do: {x, n}
    process_instruction(rest, new_data)
  end

  def process_instruction(_, data) do
    data
  end

  @spec find_intersections(any, any) :: MapSet.t(any)
  def find_intersections(list1, list2) do
    list1 |> MapSet.new() |> MapSet.intersection(MapSet.new(list2))
  end

  @spec run :: any
  def run do
    data = process_input()

    processed_list1 = Enum.at(data, 0) |> process_list |> process_instruction([{0, 0}])
    processed_list2 = Enum.at(data, 1) |> process_list |> process_instruction([{0, 0}])

    find_intersections(processed_list1, processed_list2)
    |> Enum.filter(fn {x, y} -> !(x === 0 && y === 0) end)
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end
end
