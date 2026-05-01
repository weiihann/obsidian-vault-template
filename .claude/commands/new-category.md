# Create a New Category

Create a new Obsidian category with a category page and base file.

## Arguments

The user will provide:
- **Category name** (required): e.g. "Security"
- **Sub-views** (optional): tag-based sub-views, e.g. "Auditing, Pentesting"

## Instructions

1. Check if `Categories/{Name}.md` already exists. If so, tell the user and stop.

2. Create `Categories/{Name}.md`:
```markdown
---
tags:
  - categories
---
## All

![[{Name}.base#All]]
```
If sub-views were provided, add a section for each:
```markdown
## {SubviewName}

![[{Name}.base#{SubviewName}]]
```

3. Create `Templates/Bases/{Name}.base`:
```yaml
filters:
  and:
    - categories.contains(link("{Name}"))
    - '!file.name.contains("Template")'
properties:
  file.name:
    displayName: Name
  note.tags:
    displayName: Tags
  note.url:
    displayName: URL
views:
  - type: table
    name: All
    order:
      - file.name
      - tags
      - url
    sort:
      - property: file.name
        direction: ASC
```
If sub-views were provided, add a view for each:
```yaml
  - type: table
    name: {SubviewName}
    filters:
      and:
        - note.tags.contains("{subview-tag-lowercase}")
    order:
      - file.name
      - tags
      - url
    sort:
      - property: file.name
        direction: ASC
```

**CRITICAL**: Per-view `filters:` MUST use `and:`, `or:`, or `not:` wrapper. Never use a plain list.

4. Report what was created.
