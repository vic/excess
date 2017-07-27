alias Excess, as: Xs


defimpl Xs.Producer, for: Function do
  def start(fun, listener), do: fun.({:start, listener})
  def stop(fun), do: fun.(:stop)
end
