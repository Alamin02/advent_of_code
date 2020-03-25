defmodule Intcode2 do

    def compute do
        Reader.read_data("d2")
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
        |> List.replace_at(1, 12)
        |> List.replace_at(2, 2)
        |> opcode
    end

    def opcode(state) do
        process(state, state)
    end

    def process([1, a, b, c | rest], state) do
        state = List.replace_at(
            state, 
            c, 
            apply(
                fn x, y -> x+y end,
                [Enum.at(state, a), Enum.at(state, b)]
            )
        )
        process(rest, state)
    end

    def process([2, a, b, c | rest], state) do
        state = List.replace_at(
            state, 
            c, 
            apply(
                fn x, y -> x*y end,
                [Enum.at(state, a), Enum.at(state, b)]
            )
        )
        process(rest, state)
    end

    def process([99 | _], state) do
        state
    end

end