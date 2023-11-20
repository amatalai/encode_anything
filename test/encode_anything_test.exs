defmodule EncodeAnythingTest do
  use ExUnit.Case
  use ExUnitProperties

  property "term can always be encoded" do
    check all something <- term() do
      assert {:ok, _something_encoded} = EncodeAnything.encode(something)
    end
  end

  defmodule NotAcceptableError do
    defexception message: nil, accepts: [], plug_status: 406
  end

  test "encodes error messages properly" do
    try do
      accepted = ["json", "proto"]
      format = "image"

      raise NotAcceptableError,
        message: "unknown format #{inspect(format)}, expected one of #{inspect(accepted)}",
        accepts: accepted
    rescue
      e ->
        {:ok, encoded} =
          EncodeAnything.encode(%{error: e, stacktrace: __STACKTRACE__})

        assert String.contains?(
                 encoded,
                 "\"message\":\"unknown format \\\"image\\\", expected one of [\\\"json\\\", \\\"proto\\\"]\""
               )
    end
  end
end
