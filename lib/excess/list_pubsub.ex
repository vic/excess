alias Excess, as: Xs

defmodule Xs.ListPubSub do

  @moduledoc """
  Most basic and dumb of PubSub

  This one just holds a list of listeners.

  Event notification is made sequentially.
  """

  def empty?([]), do: true
  def empty?(_), do: false

  def single?([_]), do: true
  def single?(_), do: false

  def subscribe(listeners, listener) do
    [listener | listeners]
  end

  def unsubscribe(listeners, listener) do
    List.delete(listeners, listener)
  end

  def next(listeners, value) do
    Enum.each(listeners, &Xs.Listener.next(&1, value))
  end

  def error(listeners, error) do
    Enum.each(listeners, &Xs.Listener.error(&1, error))
  end

  def complete(listeners) do
    Enum.each(listeners, &Xs.Listener.complete(&1))
  end

end


defimpl Xs.PubSub, for: List do
  defdelegate single?(pubsub), to: Xs.ListPubSub
  defdelegate empty?(pubsub), to: Xs.ListPubSub
  defdelegate subscribe(subscriber, listener), to: Xs.ListPubSub
  defdelegate unsubscribe(subscriber, listener), to: Xs.ListPubSub
end

defimpl Xs.ShamefullySend, for: List do
  defdelegate next(stream, value), to: Xs.ListPubSub
  defdelegate error(stream, value), to: Xs.ListPubSub
  defdelegate complete(stream), to: Xs.ListPubSub
end

defimpl Xs.Listener, for: List do
  defdelegate next(stream, value), to: Xs.ListPubSub
  defdelegate error(stream, value), to: Xs.ListPubSub
  defdelegate complete(stream), to: Xs.ListPubSub
end
