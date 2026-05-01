# Process Clippings into Resources

Move web clippings into the Resources system with proper categories and tags.

## Overview

Clippings are saved by Obsidian's web clipper with this frontmatter format:
```yaml
title: "..."
source: "https://..."
author:
  - "[[...]]"
published: date
created: date
description: "..."
tags:
  - "clippings"
```

This skill processes them into the vault's resource system by adding categories and tags.

## Instructions

### Phase 1: Find clippings

1. Search `Clippings/` for all `.md` files. This is where the Obsidian Web Clipper saves clippings by default. Files here are unprocessed and need categories and tags added.

2. If no files are found in `Clippings/`, tell the user and stop.

### Phase 1.5: Remove duplicates

3. Before categorizing, detect and remove duplicate clippings. A duplicate is any file where:
   - The `source` URL in frontmatter exactly matches another clipping's `source` URL, OR
   - The filename is a numbered variant of another file (e.g., `File 1.md`, `File 2.md` when `File.md` also exists)

   For each duplicate found:
   - Identify which copy to keep (prefer the one without a number suffix, or the earlier `created` date)
   - Immediately delete the duplicate using `trash` — do NOT ask for confirmation, just report what was removed
   - Report the removed files at the start of the Phase 2 table

### Phase 2: Categorize

4. For each unprocessed clipping, read the file and determine the appropriate category and tags based on:
   - The `title` property
   - The `source` URL (domain gives hints)
   - The `description` property
   - The body content (first ~50 lines)

5. Read `Categories/` to get the list of categories currently in this vault.

6. Present ALL clippings to the user in a table:
   | File | Proposed Category | Proposed Tags | Reason |
   |------|------------------|---------------|--------|

7. If any clipping doesn't fit an existing category, propose a new category name and flag it clearly.

8. **Wait for user approval/adjustments before proceeding.**

### Phase 3: Execute (after approval)

9. For each clipping, add `categories:` to the frontmatter:
   ```yaml
   categories:
     - "[[CategoryName]]"
   ```
   Insert it before the `tags:` property. Keep all existing properties (title, source, author, published, created, description) unchanged.

10. Add appropriate tags alongside the existing `clippings` tag:
    ```yaml
    tags:
      - clippings
      - {topic-tag}
      - {specific-tag}
    ```
    Tags should be lowercase.

11. If the file is NOT in `Resources/`, move it there (read content, write to `Resources/{filename}`, delete the original).

12. If a new category was approved, create it using the same pattern as `/new-category`:
    - Create `Categories/{Name}.md`
    - Create `Templates/Bases/{Name}.base`
    - **CRITICAL**: Per-view `filters:` MUST use `and:`, `or:`, or `not:` wrapper

### Phase 4: Report

13. Report:
    - How many clippings were processed
    - Breakdown by category
    - Any new categories created
    - Any files that were moved to Resources/

## Important

- Keep all original clippings properties (title, source, author, published, created, description) — only ADD categories and tags.
- A clipping can belong to multiple categories if the content spans topics.
- Prefer existing categories over creating new ones. Only create a new category if the content clearly doesn't fit any existing one AND there are multiple clippings that would use it.
- Tags should be specific and lowercase (e.g. "system-design", "prompt-engineering").
- Use existing tags from the vault where possible for consistency.
