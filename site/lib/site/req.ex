defmodule Site.Req do
  require Logger

  def add_to_block(body) do
    Logger.debug(body)
    input_shortened = body["input"]
    |> String.replace(~r/<\w+>|<\/\w+>|[<>]/, "")
    |> String.slice(0..31)

    case BlockChain.add(input_shortened) do
      {:error, :later} -> "try again later!"
      {:atomic, :ok} -> "successfully added a block!"
      _ -> "unexpected error!"
    end
  end

  def all_blocks do
    data = :mnesia.dirty_match_object({:block, :_, :_, :_, :_, :_}) |> inspect(pretty: true)
    """
    <meta charset="utf-8">
    <pre>
    #{data}
    </pre>
    """
  end
end
