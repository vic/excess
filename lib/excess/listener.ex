alias Excess, as: Xs

defprotocol Xs.Listener do

  @moduledoc """
  An xstream event listener.

  Listeners receive stream events most
  likely from a `Producer` once they are
  subscribed to it.
  """

  @doc "Notify of next event on stream"
  def next(listener, event)

  @doc "Notify of error on stream"
  def error(listener, error)

  @doc "Notify of stream termination"
  def complete(listener)

end
