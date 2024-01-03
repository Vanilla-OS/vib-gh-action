# vib-gh-action
GitHub Action to build a Vib image and optionally push it on a registry

## Usage
See [action.yml](action.yml)

```yaml
steps:
  - uses: actions/checkout@v4
  - uses: vanilla-os/vib-gh-action@v0.3.1-2
    with:
      recipe: 'myRecipe.yml'
```

default `recipe` value is `recipe.yml`.
