<%*
const name = await tp.system.prompt("Category name");
if (!name) {
  await app.vault.trash(tp.config.target_file, true);
  return;
}

if (app.vault.getAbstractFileByPath(`Categories/${name}.md`)) {
  new Notice(`Category "${name}" already exists.`);
  await app.vault.trash(tp.config.target_file, true);
  return;
}

const baseContent = `filters:
  and:
    - categories.contains(link("${name}"))
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
        direction: ASC`;

await app.vault.create(`Templates/Bases/${name}.base`, baseContent);

const categoryContent = `---
tags:
  - categories
---
## All

![[${name}.base#All]]
`;

await app.vault.create(`Categories/${name}.md`, categoryContent);

const newFile = app.vault.getAbstractFileByPath(`Categories/${name}.md`);
await app.workspace.getLeaf().openFile(newFile);

await app.vault.trash(tp.config.target_file, true);
new Notice(`Category "${name}" created!`);
-%>
