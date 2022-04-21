defmodule BlockChain.Crypto do
  @spec hash(tuple()) :: binary
  def hash(block) do
    :crypto.hash(:sha256, inspect(block))
    |> Base.encode16()
  end
end
