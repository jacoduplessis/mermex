defmodule Mermex.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/jacoduplessis/mermex"

  def project do
    [
      app: :mermex,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: "Fast Mermaid diagram to SVG rendering via native Rust NIF",
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "native/mermex_nif/.cargo",
        "native/mermex_nif/src",
        "native/mermex_nif/Cargo*",
        "native/mermex_nif/Cross.toml",
        "checksum-*.exs",
        "mix.exs"
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp deps do
    [
      {:rustler, ">= 0.0.0", optional: true},
      {:rustler_precompiled, "~> 0.8"}
    ]
  end
end
