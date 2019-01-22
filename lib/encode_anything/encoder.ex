defprotocol EncodeAnything.Encoder do
  @fallback_to_any true

  def encode(value, opts)
end

defimpl EncodeAnything.Encoder, for: Any do
  def encode(%mod{} = struct, opts) do
    %{struct | __struct__: Atom.to_string(mod)} |> EncodeAnything.Encoder.encode(opts)
  end

  def encode(value, opts) do
    value |> inspect(limit: :infinity) |> EncodeAnything.Encoder.encode(opts)
  end
end

defimpl EncodeAnything.Encoder, for: Tuple do
  def encode(tuple, opts) do
    tuple |> Tuple.to_list() |> (&[:tuple | &1]).() |> EncodeAnything.Encoder.encode(opts)
  end
end

# The following implementations are formality - they are already covered
# by the main encoding mechanism in EncodeAnything.Encode, but exist mostly for
# documentation purposes and if anybody had the idea to call the protocol directly.

defimpl EncodeAnything.Encoder, for: Atom do
  def encode(atom, opts) do
    EncodeAnything.Encode.atom(atom, opts)
  end
end

defimpl EncodeAnything.Encoder, for: Integer do
  def encode(integer, _opts) do
    EncodeAnything.Encode.integer(integer)
  end
end

defimpl EncodeAnything.Encoder, for: Float do
  def encode(float, _opts) do
    EncodeAnything.Encode.float(float)
  end
end

defimpl EncodeAnything.Encoder, for: List do
  def encode(list, opts) do
    EncodeAnything.Encode.list(list, opts)
  end
end

defimpl EncodeAnything.Encoder, for: Map do
  def encode(map, opts) do
    EncodeAnything.Encode.map(map, opts)
  end
end

defimpl EncodeAnything.Encoder, for: BitString do
  def encode(binary, opts) when is_binary(binary) do
    EncodeAnything.Encode.string(binary, opts)
  end

  def encode(bitstring, opts) do
    bitstring |> inspect(limit: :infinity) |> EncodeAnything.Encoder.encode(opts)
  end
end

defimpl EncodeAnything.Encoder, for: [Date, Time, NaiveDateTime, DateTime] do
  def encode(value, _opts) do
    [?\", @for.to_iso8601(value), ?\"]
  end
end

defimpl EncodeAnything.Encoder, for: Decimal do
  def encode(value, _opts) do
    # silence the xref warning
    decimal = Decimal
    [?\", decimal.to_string(value), ?\"]
  end
end

defimpl EncodeAnything.Encoder, for: EncodeAnything.Fragment do
  def encode(%{encode: encode}, opts) do
    encode.(opts)
  end
end
