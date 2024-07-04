# vib-gh-action

GitHub Action to build a Vib image and optionally push it to a registry.

## Usage

See [action.yml](action.yml)

```yml
steps:
  - uses: actions/checkout@v4
  - uses: vanilla-os/vib-gh-action@v0.7.3
    with:
      recipe: 'myRecipe.yml'
      plugins: org/repo:tag,org/repo:tag
```

> [!NOTE]
> The default `recipe` value is `recipe.yml`, default `plugins` value is empty.

## References

- [Vib](https://github.com/Vanilla-OS/Vib)
- [Vib plugins](https://github.com/Vanilla-OS/vib-plugin)
- [Vib image example](https://github.com/Vanilla-OS/desktop-image)
- [Vib documentation](https://docs.vanillaos.org/collections/vib)
