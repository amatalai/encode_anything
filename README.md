# EncodeAnything

Modified version of Jason.Encoder that is capable of encoding EVERY data type.
Full credit for original work goes to Michał Muskała https://github.com/michalmuskala/jason

## Use case

Sentry won't send errors to server if it cannot encode data. This means that adding some data types
(tuple, pid, ... - which are normally not encodable by libs like Jason) to Sentry.Context will make
us unaware of issue until someone will check server logs.
In this case I don't give a s*** about json standards and want as much data as possible to be sent
to sentry.

## Usage

```elixir
# mix.exs
defp deps do
  [
    {:encode_anything, git: "https://git.appunite.com/tobiasz/encode_anything"},
    {:sentry, "~> 7.0"}
  ]
end

# config/config.exs
config :sentry, json_library: EncodeAnything
```
