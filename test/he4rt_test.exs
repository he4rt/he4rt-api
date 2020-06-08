defmodule He4rtTest do
  use ExUnit.Case
  doctest He4rt

  test "greets the world" do
    assert He4rt.hello() == :world
  end
end
