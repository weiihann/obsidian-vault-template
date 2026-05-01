# Split a Tag into Subcategories

Analyze resources with a given tag, propose meaningful subcategories, and re-tag them after user approval.

## Arguments

The user will provide:
- **Tag to split** (required): e.g. "learning"
- **Category it belongs to** (required): e.g. "Career"

## Instructions

### Phase 1: Analysis

1. Find all files in `Resources/` with the specified tag.

2. Analyze the filenames and any body content to identify natural groupings of 3+ resources.

3. Present the proposed subcategories to the user as a table:
   - Subcategory name (will become a tag like "system-design")
   - Count of resources
   - Brief description of what's in it
   - Example filenames (2-3 per subcategory)

4. List any resources that don't fit a subcategory — these will get a "general" tag.

5. **Wait for user approval/adjustments before proceeding.**

### Phase 2: Execution (after approval)

6. For each resource file:
   - Replace the old tag with the new subcategory tag in the `tags:` frontmatter
   - Do NOT change categories or other properties

7. Update the category's `.base` file (`Templates/Bases/{Category}.base`) to add sub-view entries for each new subcategory:
```yaml
  - type: table
    name: {SubcategoryDisplayName}
    filters:
      and:
        - note.tags.contains("{subcategory-tag}")
    order:
      - file.name
      - tags
      - url
    sort:
      - property: file.name
        direction: ASC
```

**CRITICAL**: Per-view `filters:` MUST use `and:`, `or:`, or `not:` wrapper.

8. Update `Categories/{Category}.md` to embed the new sub-views:
```markdown
## {SubcategoryDisplayName}

![[{Category}.base#{SubcategoryDisplayName}]]
```

9. Report the final counts per subcategory.

## Important

- If analysis reveals resources that belong to a DIFFERENT existing category entirely (not just a subcategory), propose moving them there instead of creating a subcategory. Get user confirmation first.
- Keep subcategory tag names lowercase and hyphenated (e.g. "system-design", "ai-prompting").
