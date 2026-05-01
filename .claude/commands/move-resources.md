# Move Resources Between Categories

Move resources matching a tag filter from one category to another.

## Arguments

The user will provide:
- **Tag to match** (required): e.g. "business"
- **Source category** (required): e.g. "Career"
- **Destination category** (required): e.g. "Business"

## Instructions

1. Verify both categories exist in `Categories/`.

2. Search all files in `Resources/` that have the specified tag in their frontmatter `tags:` field.

3. Show the user the list of files that will be affected and the count. Ask for confirmation before proceeding.

4. For each matched file:
   - Replace `"[[SourceCategory]]"` with `"[[DestCategory]]"` in the `categories:` frontmatter
   - If the file doesn't have `"[[SourceCategory]]"` but does have the tag, add `"[[DestCategory]]"` to categories
   - Keep all other frontmatter and body content unchanged

5. Report how many files were moved.

## Important

- Only modify the `categories:` property — do NOT change tags, url, or body content.
- If a file has multiple categories, only replace the source category, keep the others.
- Use the Edit tool for each file to make targeted changes, not bulk rewrites.
