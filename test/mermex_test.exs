defmodule MermexTest do
  use ExUnit.Case
  doctest Mermex

  test "renders a flowchart to SVG" do
    {:ok, svg} = Mermex.render("flowchart LR; A-->B-->C")
    assert String.contains?(svg, "<svg")
    assert String.contains?(svg, "</svg>")
  end

  test "render! returns SVG directly" do
    svg = Mermex.render!("flowchart LR; A-->B-->C")
    assert String.contains?(svg, "<svg")
  end

  test "renders a sequence diagram" do
    diagram = """
    sequenceDiagram
        Alice->>Bob: Hello
        Bob-->>Alice: Hi
    """

    {:ok, svg} = Mermex.render(diagram)
    assert String.contains?(svg, "<svg")
    assert String.contains?(svg, "Alice")
  end

  test "renders a class diagram" do
    diagram = """
    classDiagram
        Animal <|-- Duck
        Animal: +int age
        Duck: +swim()
    """

    {:ok, svg} = Mermex.render(diagram)
    assert String.contains?(svg, "<svg")
  end

  test "renders a pie chart" do
    diagram = """
    pie title Pets
        "Dogs" : 10
        "Cats" : 5
    """

    {:ok, svg} = Mermex.render(diagram)
    assert String.contains?(svg, "<svg")
    assert String.contains?(svg, "Dogs")
  end
end
