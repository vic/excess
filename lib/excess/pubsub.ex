alias Excess, as: Xs

defprotocol Xs.PubSub do

  @moduledoc """
  Subscribe listeners to stream events
  """

  @doc "true if there is only one listener in the pubsub"
  def single?(pubsub)

  @doc "true if there are no listeners in the pubsub"
  def empty?(pubsub)

  @doc """
  Subscribe a listener to the stream.

  When invoked for the first time,
  the stream must start its internal
  producer.
  """
  def subscribe(pubsub, listener)

  @doc """
  Unsubscribe a listener from the stream.

  When removing the last listener,
  the stream must stop its internal
  producer.
  """
  def unsubscribe(pubsub, listener)

end
