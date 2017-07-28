alias Excess, as: Xs

defprotocol Xs.ShamefullySend do

  @moduledoc """
  Shamefully send events on streams that support it.

  This module name reflects it's not intended for
  regular use. Most of your code should be just
  compositions of streams. If you use functions in
  this module, it's more likely you are doing something
  in a non-reactive way, or that it's the only way
  to actually send events to your stream.

  The interface is the same as that for Listener
  but is intended for sending values.
  """

  @doc "Send next value into stream"
  def next(stream, value)

  @doc "Send error into stream"
  def error(stream, error)

  @doc "Send stream completion"
  def complete(stream)

end
