# vib-gh-action

GitHub Action to build a Vib image and optionally push it to a registry.

## Usage

See [action.yml](action.yml)

```yml
steps:
  - uses: actions/checkout@v4
  - uses: vanilla-os/vib-gh-action@v1.1.0
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

## Use of Generative AI

Maintainers may use generative AI tools as assistants while working on vib-gh-action. Non-trivial assisted commits disclose the tool, model, and scope of the work.

AI tools may assist with code comments, documentation, repetitive code, and issue triage. Maintainers make project decisions and review every assisted change before it is merged.

Use these trailers for non-trivial assisted commits:

```plain
Assisted-by: <tool>:<model-version>
AI-Scope: <what the tool generated and the prompt or a short prompt summary>
```

Single-line completions, renames, and formatting changes do not need trailers.

Coding agents must also follow [AGENTS.md](AGENTS.md) before changing files,
creating commits, or opening pull requests.
