alias Excess, as: Xs

defimpl Xs.Listener, for: Function do

  def next(fun, event) do
    fun.({:next, event})
    fun
  end

  def error(fun, error), do: fun.({:error, error})
  def complete(fun), do: fun.(:complete)

end
