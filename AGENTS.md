# dotfiler

Personal dotfiles, symlinked into place manually or with Ansible. The Doom Emacs config is the main thing edited here.

## Emacs config

- Source of truth: `emacs-config.org` (literate Doom config).
- `doom/config.el`, `doom/init.el`, `doom/packages.el`, `doom/lisp/*` are generated from it by tangling and are gitignored. Never edit them. Read them only for reference.
- `~/.config/doom` is a symlink to `doom/`.
- Do not tangle, run `doom sync`, or restart Emacs. The user does that.

### Editing `emacs-config.org`

- Put new config in the existing top-level section that fits best. Create a new `*`/`**` heading only if none fits.
- Section format: heading, then optionally one short line of Norwegian prose, then the source block:
  `#+begin_src emacs-lisp :tangle ~/repos/dotfiler/doom/config.el`
  The user writes most explanations; keep agent-written prose minimal.
- New packages: add `(package! ...)` in a block tangled to `doom/packages.el`. Doom modules: the `doom!` block in the `* init.el` section.
- Use `elisp` blocks without `:tangle` for snippets that shouldn't be tangled.
- Prefer Doom idioms: `after!`, `use-package!`, `map!`, `setq!`.
- Secrets live in `~/.emacs.secrets`, outside the repo. Never put personal or work-specific data in the org file.
- After editing, check paren balance in the changed blocks and tell the user that a `doom sync` is needed if you changed `packages.el` or `init.el`.
- Suggest small refactoring edits where appropriate, but keep these suggestions small and atomic
