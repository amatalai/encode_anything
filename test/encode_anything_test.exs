defmodule EncodeAnythingTest do
  use ExUnit.Case
  use ExUnitProperties

  property "term can always be encoded" do
    check all something <- term() do
      assert {:ok, _something_encoded} = EncodeAnything.encode(something)
    end
  end
end
