# whalebrew-compose

Run containers from [Compose][] manifests using the default behaviour of [whalebrew][].

[Compose]: https://compose-spec.io/
[whalebrew]: https://github.com/whalebrew/whalebrew

## Run

```shell
bundle install
bundle exec ./id
```

## NOTES

- Compose spec allows definition of multiple `services`, but whalebrew only allows one
- [whalebrew-packages][] install shell scripts similar to what's configured inside a "service" (`.services.<service_name>`)
  - Some keys are incompatible
- The shebang doesn't break the Compose spec, still runnable as:
  - `docker compose --file id run --rm id`
  - But this results in a different default behaviour than whalebrew
  - Clean up the created network by running: `docker compose --file id down`

[whalebrew-packages]: https://github.com/whalebrew/whalebrew-packages
