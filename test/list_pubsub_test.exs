alias Excess, as: Xs

defmodule Xs.ListPubSubTest do

  use ExUnit.Case
  use Xs.TestAsserts

  describe "List pubsub" do

    test "broadcast to all its listeners" do
      als = [agent_listener, agent_listener, agent_listener]
      agents = als |> Enum.map(&elem(&1, 0))
      listeners = als |> Enum.map(&elem(&1, 1))

      stream = %Xs.Stream{producer: nil, pubsub: listeners}
      Xs.ShamefullySend.next(stream, 42)

      assert [42, 42, 42] == agents |> Enum.map(&Agent.get(&1, fn [x] -> x end))
      agents |> Enum.each(&Agent.stop(&1))
    end

  end

end
