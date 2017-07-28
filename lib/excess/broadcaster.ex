alias Excess, as: Xs

defprotocol Xs.Broadcaster do

  @doc "true if there is only one listener in the broadcaster"
  def single?(broadcaster)

  @doc "true if there are no listeners in the broadcaster"
  def empty?(broadcaster)

end
