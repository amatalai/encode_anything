defmodule EncodeAnything.MixProject do
  use Mix.Project

  def project do
    [
      app: :encode_anything,
      version: "0.4.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.1"},
      {:stream_data, "~> 0.5", only: [:dev, :test]}
    ]
  end
end
