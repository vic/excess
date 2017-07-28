alias Excess, as: Xs

defprotocol Xs.PubSub do

  @doc "true if there is only one listener in the pubsub"
  def single?(broadcaster)

  @doc "true if there are no listeners in the pubsub"
  def empty?(broadcaster)

end
