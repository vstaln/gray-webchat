#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/webchat.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/webchat" ;;
    *) rel="x86_64-apple-darwin/webchat" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/webchat" ;;
    *) rel="x86_64-unknown-linux-musl/webchat" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/webchat.exe" "$here/target/release/webchat" "$here/target/debug/webchat.exe" "$here/target/debug/webchat"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "webchat binary not found in $here" >&2
exit 1
