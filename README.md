# vib-gh-action
GitHub Action to build a Vib image and optionally push it on a registry

## Usage
See [action.yml](action.yml)

```yaml
steps:
  - uses: actions/checkout@v4
  - name: Vib Action
    uses: vanilla-os/vib-gh@v0.3.1
```
