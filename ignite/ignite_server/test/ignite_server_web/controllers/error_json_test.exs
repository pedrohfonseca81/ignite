defmodule Ignite.ServerWeb.ErrorJSONTest do
  use Ignite.ServerWeb.ConnCase, async: true

  test "renders 404" do
    assert Ignite.ServerWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Ignite.ServerWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
