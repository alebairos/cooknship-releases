# cooknship-releases

You found the public download shelf for **cooknship** consumer builds — installers and binaries, not the product source. If you’re curious, start by installing the CLI and poking at it locally.

## Install the CLI

```bash
curl -fsSL https://github.com/alebairos/cooknship-releases/releases/latest/download/install.sh | bash
export PATH="$HOME/.local/bin:$PATH"
cooknship --version
```

That script pulls the current CLI from [Latest](https://github.com/alebairos/cooknship-releases/releases/latest) into `$HOME/.local/bin/cooknship`.

## Experiment

A small loop you can run without any private factory repo:

```bash
cooknship --help
cooknship --version
```

Optional: grab the kit tarball for a closer look:

```bash
curl -fsSL -O https://github.com/alebairos/cooknship-releases/releases/latest/download/cooknship-kit.tar.gz
```

Unpack in a throwaway directory if you like. A full “demand host” dogfood (install + ready checks against a real checkout) lives in the private factory stack and needs a host tree plus `cooknship install` and `cooknship ready .` — this repo only ships the published cut, not those workflows.

## What’s in a release

Each [Latest](https://github.com/alebairos/cooknship-releases/releases/latest) tag typically includes:

- `install.sh` — installs the CLI for your platform
- `cooknship-<target-triple>.tar.gz` — platform CLI bundles (e.g. `cooknship-x86_64-unknown-linux-gnu.tar.gz`, `cooknship-aarch64-apple-darwin.tar.gz`, …)
- `cooknship-kit.tar.gz` — consumer kit assets

“Latest” always points at the current public release (today that’s **v0.2.8** and onward).

## Guardrails

- **Not source.** Mechanism and factory live in private `cooknship-cli`, `cooknship-kit`, and `cooknship-n`. Don’t open feature PRs here.
- **Publishing** and mirroring to this host are factory HITL (**PUBLISH GO**), not something to do casually from this repo.
- **Experiment safely** — use throwaway dirs and your user install path (`~/.local/bin`); don’t treat this tree as a dev checkout.
