alias Excess, as: Xs

defmodule Xs.EnumProducerTest do

  use ExUnit.Case

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

    def assert_produced_all(producer, items) do
      {:ok, agent} = Agent.start_link(fn -> [] end)
      Xs.Producer.start(producer, fn
        {:next, event} ->
          Agent.update(agent, &([event | &1]))
        {:error, error} -> raise error
        :complete ->
          Agent.update(agent, &([:done | &1]))
      end)
      produced = Agent.get(agent, &(&1))
      assert produced == [:done | Enum.reverse(items)]
      :ok = Agent.stop(agent)
    end

  end
end
