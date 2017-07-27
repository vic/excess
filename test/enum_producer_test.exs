alias Excess, as: Xs

defmodule Xs.EnumProducerTest do

  use ExUnit.Case
  use Xs.TestAsserts

  describe "Enum producers" do

    test "produces list items" do
      list = [1, 2, 3]
      assert_produced_all(list, list)
    end

    test "produces range items" do
      range = 1..3
      assert_produced_all(range, [1, 2, 3])
    end

    test "produces an io stream items" do
      {:ok, io} = StringIO.open("hell")
      stream = IO.stream(io, 2)
      assert_produced_all(stream, ["he", "ll"])
      StringIO.close(io)
    end

    test "produces from a resource stream" do
      stream = Stream.resource(
        fn -> 0 end,
        fn x when x < 3 -> {[x], x + 1}
           x -> {:halt, x}
        end,
        fn x -> x end)
      producer = Xs.Producer.Enum.from(stream)
      assert_produced_all(producer, [0, 1, 2])
    end

  end
end
