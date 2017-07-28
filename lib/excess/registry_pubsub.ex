alias Excess, as: Xs

defmodule Xs.RegistryPubSub do

  @moduledoc """
  Implements subscriptions using a duplicate key Registry.
  """


end

defimpl Xs.PubSub, for: Xs.RegistryPubSub do
  defdelegate single?(pubsub), to: Xs.RegistryPubSub
  defdelegate empty?(pubsub), to: Xs.RegistryPubSub
  defdelegate subscribe(subscriber, listener), to: Xs.RegistryPubSub
  defdelegate unsubscribe(subscriber, listener), to: Xs.RegistryPubSub
end

defimpl Xs.ShamefullySend, for: Xs.RegistryPubSub do
  defdelegate next(stream, value), to: Xs.RegistryPubSub
  defdelegate error(stream, value), to: Xs.RegistryPubSub
  defdelegate complete(stream), to: Xs.RegistryPubSub
end

defimpl Xs.Listener, for: Xs.RegistryPubSub do
  defdelegate next(stream, value), to: Xs.RegistryPubSub
  defdelegate error(stream, value), to: Xs.RegistryPubSub
  defdelegate complete(stream), to: Xs.RegistryPubSub
end
