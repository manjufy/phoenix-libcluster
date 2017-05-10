# PhoenixLibcluster

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### Run clustering Locally

To make this work, local dev servers need to be started in "named" mode. For example, to start 2 named nodes on the same machine:

```
PORT=4000 elixir --name n1@127.0.0.1 -S mix phoenix.server &
PORT=4001 elixir --name n2@127.0.0.1 -S mix phoenix.server
```

In development, the topology is fixed and uses the built-in erlang discovery.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
