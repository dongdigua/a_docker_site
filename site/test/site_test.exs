defmodule SiteTest do
  use ExUnit.Case
  doctest Site

  test "greets the world" do
    assert Site.hello() == :world
  end
end
