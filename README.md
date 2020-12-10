# Setup COBOL (GnuCOBOL)

![GitHub release](https://img.shields.io/github/v/release/fabasoad/setup-cobol-action?include_prereleases) ![CI (latest)](https://github.com/fabasoad/setup-cobol-action/workflows/CI%20(latest)/badge.svg) ![CI (main)](https://github.com/fabasoad/setup-cobol-action/workflows/CI%20(main)/badge.svg) ![CodeQL](https://github.com/fabasoad/setup-cobol-action/workflows/CodeQL/badge.svg) ![YAML Lint](https://github.com/fabasoad/setup-cobol-action/workflows/YAML%20Lint/badge.svg) ![Shell Lint](https://github.com/fabasoad/setup-cobol-action/workflows/Shell%20Lint/badge.svg) [![Maintainability](https://api.codeclimate.com/v1/badges/84d9008a0dc1a2c6f703/maintainability)](https://codeclimate.com/github/fabasoad/setup-cobol-action/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/84d9008a0dc1a2c6f703/test_coverage)](https://codeclimate.com/github/fabasoad/setup-cobol-action/test_coverage) [![Known Vulnerabilities](https://snyk.io/test/github/fabasoad/setup-cobol-action/badge.svg?targetFile=package.json)](https://snyk.io/test/github/fabasoad/setup-cobol-action?targetFile=package.json)

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
      - uses: actions/checkout@main
      - uses: fabasoad/setup-cobol-action@main
      - name: Run script
        run: |
          cobc -x HelloWorld.cob
          ./HelloWorld
```

### Result

```shell
Run cobc -x HelloWorld.cob
Hello World!
```
