defmodule ScratchTest do
  use ExUnit.Case
  doctest Scratch

  test "greets the world" do
    assert Scratch.hello() == :world
  end
end
