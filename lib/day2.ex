defmodule Day2 do
  defmodule Submarine do
    defstruct aim: 0, depth: 0, h_pos: 0
  end

  @doc """
      iex> Day2.part1(\"""
      ...> forward 5
      ...> down 5
      ...> forward 8
      ...> up 3
      ...> down 8
      ...> forward 2
      ...> \""")
      150
  """
  def part1(input) do
    run(input, &command_1/2)
  end

  defp command_1({:forward, amount}, %Submarine{h_pos: h_pos} = submarine) do
    %{submarine | h_pos: h_pos + amount}
  end

  defp command_1({:down, amount}, %Submarine{depth: depth} = submarine) do
    %{submarine | depth: depth + amount}
  end

  defp command_1({:up, amount}, %Submarine{depth: depth} = submarine) do
    %{submarine | depth: depth - amount}
  end

  @doc """
      iex> Day2.part2(\"""
      ...> forward 5
      ...> down 5
      ...> forward 8
      ...> up 3
      ...> down 8
      ...> forward 2
      ...> \""")
      900
  """
  def part2(input) do
    run(input, &command_2/2)
  end

  defp command_2({:forward, amount}, %Submarine{} = submarine) do
    %{
      submarine
      | h_pos: submarine.h_pos + amount,
        depth: submarine.depth + submarine.aim * amount
    }
  end

  defp command_2({:down, amount}, %Submarine{aim: aim} = submarine) do
    %{submarine | aim: aim + amount}
  end

  defp command_2({:up, amount}, %Submarine{aim: aim} = submarine) do
    %{submarine | aim: aim - amount}
  end

  defp run(input, fun) do
    submarine =
      input
      |> parse_input()
      |> Enum.reduce(%Submarine{}, fun)

    submarine.h_pos * submarine.depth
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ~r/\s+/u))
    |> Enum.map(fn [direction, amount] ->
      direction = String.to_existing_atom(direction)
      amount = String.to_integer(amount)
      {direction, amount}
    end)
  end
end
