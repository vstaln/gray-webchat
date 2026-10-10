<div align="center">
  <img alt="gray-webchat" src="assets/icon.svg" width="120" height="120" />
  <h1>gray-webchat</h1>
  <p><strong>A local chat page for the agent — your harness, in a browser tab.</strong></p>
  <p>
    <a href="https://gray.alignment.id">Website</a> ·
    <a href="https://github.com/vstaln/gray-webchat">Source</a> ·
    <a href="https://github.com/vstaln/gray">gray</a>
  </p>
  <p>
    <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-1c1c20?style=flat-square&labelColor=0a0a0b" /></a>
    <a href="https://www.rust-lang.org"><img alt="Built with Rust" src="https://img.shields.io/badge/built%20with-rust-1c1c20?style=flat-square&labelColor=0a0a0b&logo=rust&logoColor=d4a373" /></a>
    <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-1c1c20?style=flat-square&labelColor=0a0a0b&color=7aa2f7" />
  </p>
</div>

<br/>
```bash
gray plugin install webchat
```

`gray-webchat` hosts a minimal chat UI on `127.0.0.1:8889` whenever the
plugin is loaded in a gray session. Send a message in the page; it becomes
a real agent turn via `host/run`; the reply streams back into the page's
log.

## Requires

The `host.turn` capability — without it `host/run` is refused and the page
logs the refusal. Grant it once:

```sh
gray plugin capabilities webchat --all
```

## How it works

- The **sidecar** owns the HTTP listener (no separate daemon): the page at
  `/`, a `POST /send` enqueue, and `GET /log?after=N` for polling.
- A pump thread turns queued messages into `host/run` wire requests —
  independent of inbound wire traffic, so messages flow while the host is
  idle. Replies land in the ring buffer keyed by the request id.
- Port: `WEBCHAT_PORT` env or `~/.gray/webchat/config.json`
  `{"port": 8889}`.

## Build from source

```sh
cargo build --release
gray plugin check ./target/release/webchat
```

## License

MIT
