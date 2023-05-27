# Setup COBOL (GnuCOBOL)

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![GitHub release](https://img.shields.io/github/v/release/fabasoad/setup-cobol-action?include_prereleases)
![functional-tests-local](https://github.com/fabasoad/setup-cobol-action/actions/workflows/functional-tests-local.yml/badge.svg)
![functional-tests-remote](https://github.com/fabasoad/setup-cobol-action/actions/workflows/functional-tests-remote.yml/badge.svg)
![pre-commit](https://github.com/fabasoad/setup-cobol-action/actions/workflows/pre-commit.yml/badge.svg)

This action sets up a [GnuCOBOL](https://en.wikipedia.org/wiki/COBOL) programming
language.

Supported OS: Linux Ubuntu.

## Inputs

<!-- prettier-ignore-start -->
| Name    | Required | Description       | Default | Possible values                        |
|---------|----------|-------------------|---------|----------------------------------------|
| version | No       | GnuCOBOL version. | `3.1.2` | `3.0-rc1`, `3.1-rc1`, `3.1.1`, `3.1.2` |
<!-- prettier-ignore-end -->

## Example usage

### Workflow configuration

```yaml
name: Setup COBOL

on: push

jobs:
  setup:
    name: Setup
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@main
      - uses: fabasoad/setup-cobol-action@main
      - name: Run script
        run: |
          cobc -x HelloWorld.cob
          ./HelloWorld
```

### Result

```text
Run cobc -x HelloWorld.cob
Hello World!
```
