defmodule BlockChain do

  def init do
    :mnesia.create_table(:block, [attributes: [:id, :timestamp, :prev_hash, :hash, :data],
      disc_copies: [node()],
      type: :ordered_set])
    try do
      prev()
    rescue
      _e in CaseClauseError -> first()
    end
  end

  def first do
    :mnesia.dirty_write(
      {:block,
      0,
      NaiveDateTime.utc_now(),
      "BEFORE BEGINNING",
      "THE BEGINNING",
      "YOU MUFFIN HEAD"}
      )
  end
  def add(data) do
    last_block = prev()
    time = NaiveDateTime.utc_now()
    if elem(last_block, 1) |> elem(2) |> NaiveDateTime.diff(time) <= -30 do
      BlockChain.Block.add_new(elem(last_block, 1), data)
    else
      {:error, :later}
    end
  end

  # prev => {:block, :id, :timestamp, :prev_hash, :hash, :data}
  def prev do
    trans = fn ->
      last = :mnesia.last(:block)
      {last, :mnesia.read({:block, last})}
    end
    case :mnesia.transaction(trans) do
      {:aborted, reason} -> {:error, reason}
      {:atomic, {last_time, [last_block]}} -> {last_time, last_block}
    end
  end

end

defmodule BlockChain.Block do
  alias BlockChain.Crypto
  def add_new(prev_block, data) do
    trans = fn -> :mnesia.write({
      :block,
      elem(prev_block, 1) + 1,
      NaiveDateTime.utc_now(),
      elem(prev_block, 4),
      Crypto.hash(prev_block),
      data,
    }) end
    :mnesia.transaction(trans)
  end
end
