alias Excess, as: Xs

defmodule Xs.TestAsserts do

  defmacro __using__(_) do
    quote do
      import Xs.TestAsserts
    end
  end

  import ExUnit.Assertions

  def agent_listener do
    {:ok, agent} = Agent.start_link(fn -> [] end)
    listener = fn
      {:next, event} ->
        Agent.update(agent, &([event | &1]))
      {:error, error} -> raise error
      :complete ->
        Agent.update(agent, &([:done | &1]))
    end
    {agent, listener}
  end

  def assert_produced_all(producer, items) do
    {agent, listener} = agent_listener()
    Xs.Producer.start(producer, listener)
    produced = Agent.get(agent, &(&1))
    assert produced == [:done | Enum.reverse(items)]
    :ok = Agent.stop(agent)
  end

end
