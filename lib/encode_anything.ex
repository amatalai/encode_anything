defmodule EncodeAnything do
  def encode(input) do
    input
    |> EncodeAnything.Encode.encode(%{escape: :json, maps: :naive})
    |> case do
      {:ok, result} -> {:ok, IO.iodata_to_binary(result)}
      {:error, error} -> {:error, error}
    end
  end

  defdelegate decode(input), to: Jason
end
