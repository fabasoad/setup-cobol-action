# Setup COBOL (GnuCOBOL)

![GitHub release](https://img.shields.io/github/v/release/fabasoad/setup-cobol-action?include_prereleases)
![Functional Tests](https://github.com/fabasoad/setup-cobol-action/workflows/Functional%20Tests%20(Remote)/badge.svg)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/fabasoad/setup-cobol-action/main.svg)](https://results.pre-commit.ci/latest/github/fabasoad/setup-cobol-action/main)

This action sets up a [GnuCOBOL](https://en.wikipedia.org/wiki/COBOL) programming
language.

Supported OS: Linux Ubuntu.

## Inputs

| Name    | Required | Description       | Default | Possible values                        |
|---------|----------|-------------------|---------|----------------------------------------|
| version | No       | GnuCOBOL version. | `3.1.2` | `3.0-rc1`, `3.1-rc1`, `3.1.1`, `3.1.2` |

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
