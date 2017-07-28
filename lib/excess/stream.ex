alias Excess, as: Xs

defmodule Xs.Stream do

  defstruct [:producer, :broadcaster]

  def subscribe(stream = %{producer: producer, broadcaster: broadcaster}, listener) do
    broadcaster = Xs.Subscriber.subscribe(broadcaster, listener)
    producer = !Xs.PubSub.single?(broadcaster) &&  producer || Xs.Producer.start(producer, stream)
    %{stream | producer: producer, broadcaster: broadcaster}
  end

  def unsubscribe(stream = %{producer: producer, broadcaster: broadcaster}, listener) do
    broadcaster = Xs.Subscriber.unsubscribe(broadcaster, listener)
    producer = !Xs.PubSub.empty?(broadcaster) && producer || Xs.Producer.stop(producer)
    %{stream | producer: producer, broadcaster: broadcaster}
  end

  def next(stream, value) do
    Xs.Listener.next(stream.broadcaster, value)
    stream
  end

  def error(stream, error) do
    Xs.Listener.error(stream.broadcaster, error)
    stream
  end

  def complete(stream) do
    Xs.Listener.complete(stream.broadcaster)
    stream
  end

end

defimpl Xs.ShamefullySend, for: Xs.Stream do
  defdelegate next(stream, value), to: Xs.Stream
  defdelegate error(stream, value), to: Xs.Stream
  defdelegate complete(stream), to: Xs.Stream
end

defimpl Xs.Listener, for: Xs.Stream do
  defdelegate next(stream, value), to: Xs.Stream
  defdelegate error(stream, value), to: Xs.Stream
  defdelegate complete(stream), to: Xs.Stream
end
