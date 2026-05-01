# Create a New Note Template

Create a new Obsidian note template following vault conventions.

## Arguments

The user will provide:
- **Template name** (required): e.g. "Book Notes"
- **Extra properties** (optional): e.g. "author, rating"
- **Body sections** (optional): e.g. "Summary, Key Takeaways, Quotes"

## Instructions

1. Check if `Templates/{Name} Template.md` already exists. If so, tell the user and stop.

2. Create `Templates/{Name} Template.md` with this structure:

```markdown
---
created: {{date}}
{extra properties, one per line, with empty values}
tags:
  - note
  - {template-name-lowercase}
---
```

For extra properties:
- Use lowercase property names
- Leave values empty (the user fills them in when creating a note)

3. If body sections were specified, add them as `## Heading` sections.

4. If no body sections were specified, add a minimal default:
```markdown
## Notes


```

5. Ask the user if they want a corresponding `.base` file to query notes of this type. If yes:
   - Create `Templates/Bases/{Name}.base` filtering on `file.tags.contains("{tag}")`
   - Create a dashboard page at `Notes/{Name}.md` embedding the base
   - Include `created` and any extra properties as columns

## Vault Conventions

- Date property: `created: {{date}}` (Obsidian core templates syntax)
- Tags always include `note` plus the template type
- Templates live in `Templates/`
- Base files live in `Templates/Bases/`
- Dashboard pages live in `Notes/`
