defmodule AgalaFbTest do
  use ExUnit.Case
  doctest AgalaFb

  test "greets the world" do
    assert AgalaFb.hello() == :world
  end
end
