defmodule Site.Req do
  def add_to_block(query_string) do
    input_shortened = Regex.run(~r/^input=(\w+)$/, query_string) |> tl() |> hd() |> String.slice(0..31)

    case BlockChain.add(input_shortened) do
      {:error, :later} -> "try again later!"
      {:atomic, :ok} -> "successfully added a block!"
      _ -> "unexpected error!"
    end
  end

  def all_blocks do
    :mnesia.match_object({:block, :_, :_, :_, :_, :_}) |> inspect(pretty: true)
  end
end
