alias Excess, as: Xs

defmodule Xs.ListBroadcaster do

  @moduledoc """
  Most basic and dumb of broadcasters

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


defimpl Xs.Broadcaster, for: List do
  defdelegate single?(broadcaster), to: Xs.ListBroadcaster
  defdelegate empty?(broadcaster), to: Xs.ListBroadcaster
end

defimpl Xs.Subscriber, for: List do
  defdelegate subscribe(subscriber, listener), to: Xs.ListBroadcaster
  defdelegate unsubscribe(subscriber, listener), to: Xs.ListBroadcaster
end

defimpl Xs.ShamefullySend, for: List do
  defdelegate next(stream, value), to: Xs.ListBroadcaster
  defdelegate error(stream, value), to: Xs.ListBroadcaster
  defdelegate complete(stream), to: Xs.ListBroadcaster
end

defimpl Xs.Listener, for: List do
  defdelegate next(stream, value), to: Xs.ListBroadcaster
  defdelegate error(stream, value), to: Xs.ListBroadcaster
  defdelegate complete(stream), to: Xs.ListBroadcaster
end
