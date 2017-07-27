alias Excess, as: Xs

defprotocol Xs.Producer do

  @moduledoc """
  An xstream producer.

  Producers generate events lazily, and only once
  a listener has been attached to then by using
  the `start/1` function.

  The producer can be asked to stop producing events
  when called `stop/0`.

  The producer can be started and stopped many
  times.

  The behaviour of calling `start/1` many times
  with different listeners is left to the implementation.

  As some producers could be *shared* (sending the
  same events to all attached listeners) or perhaps
  *memoized* (sending the latest event to newly added
  listeners).

  Also, each implementation is free to use any means of
  parallelism it desires, say use `GenStage`s or even
  use run everything on the same process.
  """

  @doc "Start producing stream events to the given listener"
  def start(producer, listener)

  @doc "Stop producing stream events"
  def stop(producer)

end
