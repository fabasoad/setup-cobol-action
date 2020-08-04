# Setup COBOL (GnuCOBOL)
![GitHub release](https://img.shields.io/github/v/release/fabasoad/setup-cobol-action?include_prereleases) ![CI (latest)](https://github.com/fabasoad/setup-cobol-action/workflows/CI%20(latest)/badge.svg) ![CI (main)](https://github.com/fabasoad/setup-cobol-action/workflows/CI%20(main)/badge.svg) ![YAML Lint](https://github.com/fabasoad/setup-cobol-action/workflows/YAML%20Lint/badge.svg) ![Shell Lint](https://github.com/fabasoad/setup-cobol-action/workflows/Shell%20Lint/badge.svg)

This action sets up a [GnuCOBOL](https://en.wikipedia.org/wiki/COBOL) programming language. Currently supports Linux Ubuntu only.

## Inputs
| Name    | Required | Description                                          | Default   | Possible values |
|---------|----------|------------------------------------------------------|-----------|-----------------|
| version | No       | GnuCOBOL version. Currently supports `3.0-rc1` only. | `3.0-rc1` | `3.0-rc1`       |

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
      - uses: actions/checkout@master
      - uses: fabasoad/setup-cobol-action@main
      - name: Run script
        run: |
          cobc -x HelloWorld.cob
          ./HelloWorld
```

### Result
![Result](https://raw.githubusercontent.com/fabasoad/setup-cobol-action/main/screenshot.png)
