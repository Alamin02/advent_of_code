defmodule Intcode2 do

    def compute do
        Reader.read_data("d2")
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
        |> run(input_pairs(), 0)
    end

    def run(_, [{noun, verb} | _], 19690720) do
        100 * noun + verb
    end

    def run(list, [{noun, verb} | rest], _) do
        new_list = add_inputs(list, noun, verb)
        run(list, rest, opcode(new_list))
    end

    def add_inputs(list, noun, verb) do
        list
        |> List.replace_at(1, noun)
        |> List.replace_at(2, verb)
    end

    def opcode(state) do
        process(state, state)
        |> Enum.at(0)
    end

    def process([99 | _], state) do
        state
    end

    def process([op, a, b, c | rest], state) do
        state = List.replace_at(
            state, 
            c, 
            apply(
                case op do
                    1 -> &Kernel.+/2
                    2 -> &Kernel.*/2
                end,
                [Enum.at(state, a), Enum.at(state, b)]
            )
        )
        process(rest, state)
    end

    def input_pairs do
        for noun <- 1..99, verb <- 1..99 do
            {noun, verb}
        end
    end

end