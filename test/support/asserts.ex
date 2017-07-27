alias Excess, as: Xs

defmodule Xs.TestAsserts do

  defmacro __using__(_) do
    quote do
      import Xs.TestAsserts
    end
  end

  import ExUnit.Assertions

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
