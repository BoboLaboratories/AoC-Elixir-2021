defmodule Day1 do
  @doc """
      iex> Day1.part1(\"""
      ...> 199
      ...> 200
      ...> 208
      ...> 210
      ...> 200
      ...> 207
      ...> 240
      ...> 269
      ...> 260
      ...> 263
      ...> \""")
      7
  """
  def part1(input) do
    input
    |> parse_input()
    |> count_increments()
  end

  @doc """
      iex> Day1.part2(\"""
      ...> 199
      ...> 200
      ...> 208
      ...> 210
      ...> 200
      ...> 207
      ...> 240
      ...> 269
      ...> 260
      ...> 263
      ...> \""")
      5
  """
  def part2(input) do
    input
    |> parse_input()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> count_increments()
  end

  defp count_increments(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [prev, next] -> prev < next end)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
