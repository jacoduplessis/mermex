defmodule Mermex do
  @moduledoc """
  Render Mermaid diagrams to SVG using a native Rust renderer.

  Wraps the `mermaid-rs-renderer` Rust crate via Rustler NIFs for
  fast, browser-free Mermaid-to-SVG conversion.
  """

  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :mermex,
    crate: "mermex_nif",
    base_url: "https://github.com/jacoduplessis/mermex/releases/download/v#{version}",
    force_build: System.get_env("MERMEX_BUILD") in ["1", "true"],
    nif_versions: ["2.15", "2.16", "2.17"],
    version: version

  @doc """
  Renders a Mermaid diagram string to an SVG binary.

  Returns `{:ok, svg}` on success or `{:error, reason}` on failure.

  ## Examples

      iex> {:ok, svg} = Mermex.render("flowchart LR; A-->B-->C")
      iex> String.contains?(svg, "<svg")
      true

  """
  @spec render(binary()) :: {:ok, binary()} | {:error, binary()}
  def render(_diagram), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Like `render/1` but raises on error.

  ## Examples

      iex> svg = Mermex.render!("flowchart LR; A-->B-->C")
      iex> String.contains?(svg, "<svg")
      true

  """
  @spec render!(binary()) :: binary()
  def render!(diagram) do
    case render(diagram) do
      {:ok, svg} -> svg
      {:error, reason} -> raise "Mermex render failed: #{reason}"
    end
  end
end
