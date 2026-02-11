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

  ## Options

    * `:font_family` - CSS font-family string (default: modern theme font stack)
    * `:font_size` - Font size in pixels (default: 14.0)
    * `:node_spacing` - Horizontal spacing between nodes (default: 50.0)
    * `:rank_spacing` - Vertical spacing between ranks (default: 50.0)

  ## Examples

      iex> {:ok, svg} = Mermex.render("flowchart LR; A-->B-->C")
      iex> String.contains?(svg, "<svg")
      true

  """
  @spec render(binary(), keyword()) :: {:ok, binary()} | {:error, binary()}
  def render(diagram, opts \\ []) do
    native_render(diagram, to_opts_map(opts))
  end

  @doc """
  Like `render/1` but raises on error.

  ## Examples

      iex> svg = Mermex.render!("flowchart LR; A-->B-->C")
      iex> String.contains?(svg, "<svg")
      true

  """
  @spec render!(binary(), keyword()) :: binary()
  def render!(diagram, opts \\ []) do
    case render(diagram, opts) do
      {:ok, svg} -> svg
      {:error, reason} -> raise "Mermex render failed: #{reason}"
    end
  end

  @doc false
  def native_render(_diagram, _opts), do: :erlang.nif_error(:nif_not_loaded)

  defp to_opts_map(opts) do
    %{
      font_family: Keyword.get(opts, :font_family),
      font_size: to_float(Keyword.get(opts, :font_size)),
      node_spacing: to_float(Keyword.get(opts, :node_spacing)),
      rank_spacing: to_float(Keyword.get(opts, :rank_spacing))
    }
  end

  defp to_float(nil), do: nil
  defp to_float(n) when is_float(n), do: n
  defp to_float(n) when is_integer(n), do: n * 1.0
end
