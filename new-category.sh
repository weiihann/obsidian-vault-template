#!/bin/bash
# Usage: ./new-category.sh "Books"
# Creates Categories/Books.md and Templates/Bases/Books.base

NAME="$1"

if [ -z "$NAME" ]; then
  echo "Usage: ./new-category.sh <CategoryName>"
  exit 1
fi

if [ -f "Categories/${NAME}.md" ]; then
  echo "Category '${NAME}' already exists."
  exit 1
fi

# Create the category page
cat > "Categories/${NAME}.md" << EOF
---
tags:
  - categories
---
## All

![[${NAME}.base#All]]

EOF

# Create the base file with minimal defaults
cat > "Templates/Bases/${NAME}.base" << EOF
filters:
  and:
    - categories.contains(link("${NAME}"))
    - '!file.name.contains("Template")'
properties:
  file.name:
    displayName: Name
  note.rating:
    displayName: Rating
  note.created:
    displayName: Created
  note.tags:
    displayName: Tags
views:
  - type: table
    name: All
    order:
      - file.name
      - rating
      - created
      - tags
    sort:
      - property: file.name
        direction: ASC
EOF

echo "Created:"
echo "  Categories/${NAME}.md"
echo "  Templates/Bases/${NAME}.base"
echo ""
echo "Edit Templates/Bases/${NAME}.base to customize properties and views."
