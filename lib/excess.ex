alias Excess, as: Xs

defmodule Xs do
  @moduledoc """
  Documentation for Excess.
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

  def create(producer) do
  end
end
