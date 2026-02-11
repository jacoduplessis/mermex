# Mermex

Fast Mermaid diagram to SVG rendering for Elixir, powered by a native Rust NIF.

Wraps [mermaid-rs-renderer](https://github.com/1jehuang/mermaid-rs-renderer) via [Rustler](https://github.com/rusterlium/rustler), providing 100-1400x faster rendering than mermaid-cli with no browser or Node.js dependency.

Supports 23 diagram types including flowcharts, sequence diagrams, class diagrams, state diagrams, ER diagrams, pie charts, Gantt charts, and more.

## Installation

Add `mermex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mermex, "~> 0.1.0"}
  ]
end
```

Precompiled NIFs are available for the most common targets. If you need to compile from source, install Rust and set:

```sh
export MERMEX_BUILD=true
```

## Usage

```elixir
# Returns {:ok, svg} or {:error, reason}
{:ok, svg} = Mermex.render("flowchart LR; A-->B-->C")

# Bang variant - returns SVG string or raises
svg = Mermex.render!("flowchart LR; A-->B-->C")
```

```elixir
diagram = """
sequenceDiagram
    Alice->>Bob: Hello Bob, how are you?
    Bob-->>Alice: Great!
"""

{:ok, svg} = Mermex.render(diagram)
File.write!("diagram.svg", svg)
```

## Supported diagram types

Flowcharts, sequence diagrams, class diagrams, state diagrams, ER diagrams, pie charts, XY charts, quadrant charts, Gantt charts, timelines, journey maps, mindmaps, and git graphs.

## License

MIT
