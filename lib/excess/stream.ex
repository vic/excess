alias Excess, as: Xs

defmodule Xs.Stream do

  defstruct [:producer, :pubsub]

  def subscribe(stream = %{producer: producer, pubsub: pubsub}, listener) do
    pubsub = Xs.Subscriber.subscribe(pubsub, listener)
    producer = !Xs.PubSub.single?(pubsub) &&  producer || Xs.Producer.start(producer, stream)
    %{stream | producer: producer, pubsub: pubsub}
  end

  def unsubscribe(stream = %{producer: producer, pubsub: pubsub}, listener) do
    pubsub = Xs.Subscriber.unsubscribe(pubsub, listener)
    producer = !Xs.PubSub.empty?(pubsub) && producer || Xs.Producer.stop(producer)
    %{stream | producer: producer, pubsub: pubsub}
  end

  def next(stream, value) do
    Xs.Listener.next(stream.pubsub, value)
    stream
  end

  def error(stream, error) do
    Xs.Listener.error(stream.pubsub, error)
    stream
  end

  def complete(stream) do
    Xs.Listener.complete(stream.pubsub)
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
