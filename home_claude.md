## Interactions

NEVER OFFER AND NEVER POST COMMENTS TO SLACK, LINEAR, NOTION, OR GITHUB.

## Source location References

When you reference a source location, render it as a markdown link
[DISPLAY](https://openloc.invalid/o?p=PATH:LINE). PATH is the ABSOLUTE file
path and LINE is the line number, so the link resolves whatever the working
directory is. Do not percent-encode PATH, a plain / needs no escape. Keep
DISPLAY short, the workspace-relative path:line. Example:
[src/app.ts:42](https://openloc.invalid/o?p=/home/me/proj/src/app.ts:42)

## Branch names

Every branch should follow the same pattern:

`<my-initials>/<type>/<scope>/<short-description>`

e.g.

`do/chore/manager-excluded-forms/remove-deprecated-flag`

## Stacked branches

I typically use stacked branches to break up large features into smaller,
tightly focused PRs. When starting a discussion, use the custom `lom` alias git
command to view the structure of the current branch as it relates to `main`.

## Pull requests

- NEVER open a PR without asking first.
- If allowed to open a PR or the user states to open a PR, ALWAYS open a DRAFT PR.

## Commit Organization

- Each commit should be accompanied by tests, if applicable, rather than having a test only commit later in the commit series
- Each commit should build upon the previous commits. Tell a story and build up the branch logically.

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

## Code comments (JS/CSS/Ruby/etc.)

DO NOT WRITE CODE COMMENTS
DO NOT WRITE CODE COMMENTS
DO NOT WRITE CODE COMMENTS

## Ruby preferences

When writing Ruby 3.1+, STRONGLY prefer using the shorthand block syntax when
possible.

```ruby
# Bad
[1, 2, 3].each { |n| puts n }
```

```ruby
# Good
[1, 2, 3].each { puts it }
```

## RSpec Test Writing Conventions

When writing RSpec tests, follow these patterns:

### Alphabetical Ordering

Always organize describe blocks for methods in **alphabetical order** within
the spec file. This ensures consistency and makes tests easy to find.

### Subject Chaining

Use `subject { super().method_name }` to chain off the main subject,
maintaining clean test structure while testing individual methods.

```ruby describe "#method_name" do subject { super().method_name }

it { is_expected.to eq(expected_value) } end ```

## Work rules

Work-specific rules load from `~/.claude/work_claude.md` via the
`work-context.sh` SessionStart hook. That file is intentionally not in this
repo.
