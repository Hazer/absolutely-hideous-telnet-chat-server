# App

Start the application with

```elixir
App.accept(9000)
```

Then go into another shell session and type in

```bash
telnet localhost 9000
```

Do it again for another window.

Start chatting and see results. It's hideous! But it scales well with the only bottleneck being the genserver's speed of inserting/fetching the state. 


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `app` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:app, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/app](https://hexdocs.pm/app).

