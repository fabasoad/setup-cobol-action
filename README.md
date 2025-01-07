# Setup COBOL (GnuCOBOL)

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![GitHub release](https://img.shields.io/github/v/release/fabasoad/setup-cobol-action?include_prereleases)
![functional-tests-local](https://github.com/fabasoad/setup-cobol-action/actions/workflows/functional-tests-local.yml/badge.svg)
![functional-tests-remote](https://github.com/fabasoad/setup-cobol-action/actions/workflows/functional-tests-remote.yml/badge.svg)
![security](https://github.com/fabasoad/setup-cobol-action/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/setup-cobol-action/actions/workflows/linting.yml/badge.svg)

This action sets up a [GnuCOBOL](https://en.wikipedia.org/wiki/COBOL) programming
language.

## Supported OS

<!-- prettier-ignore-start -->
| OS      |                    |
|---------|--------------------|
| Windows | :x:                |
| Linux   | :white_check_mark: |
| macOS   | :x:                |
<!-- prettier-ignore-end -->

## Inputs

```yaml
- uses: fabasoad/setup-cobol-action@v1
  with:
    # (Optional) GnuCOBOL version. Defaults to 3.1.2.
    version: "3.1.2"
```

## Outputs

None.

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
      - uses: actions/checkout@v4
      - uses: fabasoad/setup-cobol-action@v1
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
