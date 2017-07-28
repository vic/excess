alias Excess, as: Xs

defprotocol Xs.Subscriber do

  @moduledoc """
  Subscribe listeners to stream events
  """

  @doc """
  Subscribe a listener to the stream.

  When invoked for the first time,
  the stream must start its internal
  producer.
  """
  def subscribe(subscriber, listener)

  @doc """
  Unsubscribe a listener from the stream.

  When removing the last listener,
  the stream must stop its internal
  producer.
  """
  def unsubscribe(subscriber, listener)

end
