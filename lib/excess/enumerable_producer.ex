alias Excess, as: Xs

defmodule Xs.Producer.Enum do
  @moduledoc """
  A very simple synchronous producer for enumerable collections.

  Once started, this producer emits all values from the enumerable
  using `Enum.each/2`, that is, lazy streams will be consumed once
  a listener is added to the producer.

  Everything happens synchronously, `start/2` does not return until
  all of the enumerable values have been produced and sent to the
  listener. `stop/1` does nothing.
  """

  defstruct [:enum]

  defmacro __using__(_) do
    quote do
      defdelegate start(producer, listener), to: Xs.Producer.Enum
      defdelegate stop(producer), to: Xs.Producer.Enum
    end
  end

  def start(%__MODULE__{enum: enum}, listener) do
    start(enum, listener)
  end

  def start(enum, listener) do
    :ok = Enum.each(enum, &Xs.Listener.next(listener, &1))
    Xs.Listener.complete(listener)
  end

  def stop(_enum), do: :ok

  @doc "Creates a producer from an enumerable"
  def from(enumerable) do
    %__MODULE__{enum: enumerable}
  end
end

defimpl Xs.Producer, for: Xs.Producer.Enum do
  use Xs.Producer.Enum
end

defimpl Xs.Producer, for: List do
  use Xs.Producer.Enum
end

defimpl Xs.Producer, for: Range do
  use Xs.Producer.Enum
end

defimpl Xs.Producer, for: IO.Stream do
  use Xs.Producer.Enum
end
