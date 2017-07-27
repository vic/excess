alias Excess, as: Xs

defmodule Xs.FunctionProducerTest do

  use ExUnit.Case
  use Xs.TestAsserts

  describe "Function producer" do

    test "produces list items" do
      producer = fn
        {:start, listener} ->
          listener
          |> Xs.Listener.next(1)
          |> Xs.Listener.next(2)
          |> Xs.Listener.complete
      end
      assert_produced_all(producer, [1, 2])
    end
  end
end
