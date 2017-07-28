alias Excess, as: Xs

defmodule Xs do

  @moduledoc """
  Excess implements Reactive Streams modeled
  after the xstream javascript library.

  A listener attached to an xstream can be
  notified when the stream produces a new
  event data or when the stream signals an
  error or the stream completes normally.

  An stream can be composed with others,
  mapped or filtered, in such cases, errors
  are propagated along dependent streams.
  """

  @doc """
  Produce a single value and then completes.

  The value is produced once the first listener
  subscribes.
  """
  def from(term) do
    create(fn
      {:start, listener} ->
        listener
        |> Xs.Listener.next(term)
        |> Xs.Listener.complete
      :stop -> :ok
    end)
  end

  @doc """
  Produces the value of calling the given function.
  If the function raises, the error is sent to the
  listener.
  Completes just after the value has been produced.
  """
  def from_apply(callable)

  def from_apply({mod, fun, args}) when is_atom(mod) and is_atom(fun) and is_list(args) do
    from_apply(fn -> apply(mod, fun, args) end)
  end

  def from_apply(fun) when is_function(fun, 0) do
    create(fn
      {:start, listener} ->
        try do
          fun.()
        rescue
          error -> Xs.Listener.error(listener, error)
        else
          value ->
            listener
            |> Xs.Listener.next(value)
            |> Xs.Listener.complete()
        end

      :stop -> :ok
    end)
  end

  def create(_producer) do
  end
end
