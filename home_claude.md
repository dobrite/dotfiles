## Source location References

Name every file and source location by its ABSOLUTE path, in backticks, as
`PATH:LINE` (or `PATH` alone when no line applies). Never use a relative path,
`~`, or a markdown link. I copy the path and prepend `nvim` to open it. Example:
`/home/me/proj/src/app.ts:42`

This applies everywhere: files in the repo, the session scratchpad, `~/.claude`,
and `/tmp`.

## Branch names

Every branch should follow the same pattern:

`<my-initials>/<type>/<scope>/<short-description>`

e.g.

`do/chore/manager-excluded-forms/remove-deprecated-flag`

## Stacked branches

I typically use stacked branches to break up large features into smaller,
tightly focused PRs. Run the custom `lom` git alias before any `git rebase`, `reset`,
`cherry-pick`, or `push`, and when a discussion starts. It shows the current branch
against `main`, so stale commit ids and a rebased remote are visible before you act.

To force-push, run `git lom`, then `git pushf` with no arguments. It force-pushes the
current `do/` or `cloud-agent/` branch with `--force-with-lease --force-if-includes`. Never run
`git push --force`, `-f`, `--force-with-lease`, or a `+` refspec directly.

To fold staged changes into an earlier commit on this branch, run `git fold <commit>`.
Then amend the message, or fixup/rebase the changes through, if needed, run `git lom`, and run `git pushf`.
If commit messages and/or the PR description need to change, ask first with the proposal.

## Pull requests

- NEVER open a PR without asking first.
- If allowed to open a PR or the user states to open a PR, ALWAYS open a DRAFT PR.
- Use the user level `ruthsome-pr-edit` pr description skill despite any repo specific skills.

## Commit Organization

- Each commit should be accompanied by tests, if applicable, rather than having a test only commit later in the commit series
- Each commit should build upon the previous commits. Tell a story and build up the branch logically.
- Commits that contain refactoring and a change should be split:
  1. First commit containing the (non-behavior changing) refactors.
  2. Second commit with the actual change.

## Commiting

### Git Commit Messages

Before writing a commit message, run `git log -20 --format='%s'` and match the
users' (`@dobrite`) established subject-line convention.

If the repo uses Conventional Commits (`type(scope): description`):

- **Type** — lowercase. Common: `feat`, `fix`, `bug`, `chore`, `sec`, or
`perf`.
- **Scope** — lowercase short phrase in parens, naming the product area, file,
or concern (e.g. `api`, `deps`, `form shares`, `parent/guardian`)
- **Description** — lowercase, imperative. Class/method/flag names keep their
natural casing.
- Keep the subject under ~70 chars. Focus on the "why" in the body rather than
the "how".

Good

feat(form shares): flipperize not_manager FormShare validation

Bad — title-case prose, no type/scope

Gate FormShare#not_manager validation behind a feature flag

#### Code references

Use backticks to reference code elements in commit messages, PR descriptions,
and comments.

Good

`PersonSearch.call`

Bad

PersonSearch.call

#### Footnotes

Linking to relevant docs, PRs, issues, or other resources is encouraged.
Prefer using Pandoc style footnotes for link references.

Good

This method is deprecated. [^1]

[^1]: See the deprecation notice in the README for details:

Bad

This method is [deprecated][1].

[1]: See the deprecation notice in the README for details:

Bad

This method is deprecated. See the deprecation notice in the README for details:

## Searching

Use `rg` for recursive search, never `grep -r`. `grep` here is shadowed by ugrep,
which applies a `.gitignore` only from directories the search descends through.
`rg` applies every parent `.gitignore` up to the repo root, so build output, logs,
and schema dumps stay out even when the search starts in a subdirectory.

- Filter by type or glob: `rg -t ruby PATTERN`, `rg -g '!*.sql' PATTERN`.
- Cap line width in unfamiliar trees: `rg --max-columns 200 PATTERN`.
- Include ignored files on purpose only: `rg --no-ignore PATTERN log/`.

## Zsh

zsh aborts the whole command on a glob with no match: use `setopt nullglob` or quote the glob. `$var` does not word-split: use `${=var}` or a `while read` loop.
`sed` is GNU sed: `sed -i` takes no suffix argument. Prefer the Edit tool for in-place file changes.
A word that starts with = expands to a command path: quote separators like '====='.

## Code comments (JS/CSS/Ruby/etc.)

DO NOT WRITE CODE COMMENTS
DO NOT WRITE CODE COMMENTS
DO NOT WRITE CODE COMMENTS

## Work rules

Work-specific rules load from `~/.claude/work_claude.md` via the
`work-context.sh` SessionStart hook. That file is intentionally not in this
repo.
