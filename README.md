# PhoenixCowboyRemoveServerHeader

[![CircleCI](https://circleci.com/gh/hirocaster/phoenix_cowboy_remove_server_header.svg?style=svg)](https://circleci.com/gh/hirocaster/phoenix_cowboy_remove_server_header)

Remove `server: Cowboy` in http headers from [Phoenix](http://www.phoenixframework.org/).

```
HTTP/1.1 200 OK
server: Cowboy <--- Will remove by this module !!
date: Tue, 11 Apr 2017 15:18:46 GMT
content-length: 1933
content-type: text/html; charset=utf-8
```

## Usage

``` elixir
defmodule MyApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    PhoenixCowboyRemoveServerHeader.enable_for(:my_app, __MODULE__.Endpoint) # Add in your app

```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `phoenix_cowboy_remove_server_header` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:phoenix_cowboy_remove_server_header, "~> 0.1.0"}]
    end
    ```

  2. Ensure `phoenix_cowboy_remove_server_header` is started before your application:

    ```elixir
    def application do
      [applications: [:phoenix_cowboy_remove_server_header]]
    end
    ```
