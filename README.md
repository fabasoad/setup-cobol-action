# Setup COBOL (GnuCOBOL)

![GitHub release](https://img.shields.io/github/v/release/fabasoad/setup-cobol-action?include_prereleases)
![Unit Tests](https://github.com/fabasoad/setup-cobol-action/workflows/Unit%20Tests/badge.svg)
![Functional Tests](https://github.com/fabasoad/setup-cobol-action/workflows/Functional%20Tests/badge.svg)
![Security Tests](https://github.com/fabasoad/setup-cobol-action/workflows/Security%20Tests/badge.svg)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/fabasoad/setup-cobol-action/main.svg)](https://results.pre-commit.ci/latest/github/fabasoad/setup-cobol-action/main)
[![Maintainability](https://api.codeclimate.com/v1/badges/84d9008a0dc1a2c6f703/maintainability)](https://codeclimate.com/github/fabasoad/setup-cobol-action/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/84d9008a0dc1a2c6f703/test_coverage)](https://codeclimate.com/github/fabasoad/setup-cobol-action/test_coverage)
[![Known Vulnerabilities](https://snyk.io/test/github/fabasoad/setup-cobol-action/badge.svg?targetFile=package.json)](https://snyk.io/test/github/fabasoad/setup-cobol-action?targetFile=package.json)

This action sets up a [GnuCOBOL](https://en.wikipedia.org/wiki/COBOL) programming
language. Currently, supports Linux Ubuntu only.

## Inputs

<!-- markdownlint-disable MD013 -->
| Name    | Required | Description       | Default | Possible values                        |
|---------|----------|-------------------|---------|----------------------------------------|
| version | No       | GnuCOBOL version. | `3.1.2` | `3.0-rc1`, `3.1-rc1`, `3.1.1`, `3.1.2` |
<!-- markdownlint-enable MD013 -->

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
