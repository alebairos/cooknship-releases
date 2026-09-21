#!/usr/bin/env sh
# Minimal public mirror integrity check for alebairos/cooknship-releases.
set -eu

REPO=${REPO:-alebairos/cooknship-releases}
TAG=${TAG:-v0.2.11}
PUBLIC_BASE="https://github.com/${REPO}/releases/download/${TAG}"

REQUIRED_ASSETS="
install.sh
cooknship-kit.tar.gz
cooknship-aarch64-apple-darwin.tar.gz
cooknship-x86_64-unknown-linux-gnu.tar.gz
"

gh_cmd() {
  env -u GH_TOKEN gh "$@"
}

die() {
  echo "smoke-mirror: $1" >&2
  exit 1
}

require_asset() {
  name=$1
  size=$(gh_cmd release view "$TAG" --repo "$REPO" --json assets -q ".assets[] | select(.name==\"$name\") | .size") \
    || die "cannot read release assets for $REPO $TAG"
  test -n "$size" || die "missing asset $name on $REPO $TAG"
  test "$size" -gt 0 || die "empty asset $name on $REPO $TAG"
}

require_http200() {
  url=$1
  code=$(curl -fsI -o /dev/null -w '%{http_code}' -L "$url") || die "HEAD failed: $url"
  test "$code" = 200 || die "HTTP $code for $url"
}

latest=$(gh_cmd release view --repo "$REPO" --json tagName -q .tagName) || die "cannot read latest release"
test "$latest" = "$TAG" || die "latest release is $latest, expected $TAG"

for name in $REQUIRED_ASSETS; do
  require_asset "$name"
  require_http200 "${PUBLIC_BASE}/${name}"
done

echo "smoke-mirror: PASS $REPO $TAG (assets + anonymous GET)"
