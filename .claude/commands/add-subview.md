# Add a Sub-view to an Existing Category

Add a new filtered sub-view tab to an existing category's base file and category page.

## Arguments

The user will provide:
- **Category name** (required): e.g. "Knowledge"
- **Sub-view name** (required): e.g. "Books"
- **Filter tag** (optional): defaults to the sub-view name lowercased, e.g. "books"

## Instructions

1. Read `Templates/Bases/{Category}.base` — if it doesn't exist, tell the user and stop.

2. Read `Categories/{Category}.md`.

3. Add a new view to the `.base` file's `views:` array:
```yaml
  - type: table
    name: {SubviewName}
    filters:
      and:
        - note.tags.contains("{filter-tag-lowercase}")
    order:
      - file.name
      - tags
      - url
    sort:
      - property: file.name
        direction: ASC
```

**CRITICAL**: Per-view `filters:` MUST use `and:`, `or:`, or `not:` wrapper. Never use a plain list.

4. Add the corresponding embed to `Categories/{Category}.md`:
```markdown

## {SubviewName}

![[{Category}.base#{SubviewName}]]
```

5. Report what was added.
