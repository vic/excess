defmodule Excess.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [app: :excess,
     version: @version,
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     source_url: "https://github.com/vic/excess",
     docs: [source_ref: "v#{@version}", main: "Excess"],
     elixirc_paths: elixirc_paths(Mix.env),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp package do
    [description: "Excess",
     files: ["lib", "mix.exs", "README*"],
     maintainers: ["Victor Borja <vborja@apache.org>"],
     licenses: ["Apache-2"],
     links: %{github: "https://github.com/vic/excess"}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]


  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:gen_stage, "~> 0.12"},
      {:ex_doc, "~> 0.14", only: :dev},
    ]
  end
end
