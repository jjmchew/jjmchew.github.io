# VSCode notes

## Settings
- are all in `settings.json`
  - can be found via preferences menu

updated `settings.json` file to turn off all pop-ups, suggestions, highlighting:
```json
  "editor.matchBrackets": "never",
  "editor.parameterHints.enabled": false,
  "editor.quickSuggestions": {
      "other": "off",
      "comments": "off",
      "strings": "off"
  },
  "editor.suggestOnTriggerCharacters": false,
  "editor.wordBasedSuggestions": false,
  "editor.hover.enabled": false,
  "workbench.editor.enablePreview": false,
  "editor.occurrencesHighlight": false,
  "editor.selectionHighlight": false,
  "extensions.ignoreRecommendations": true,
  "explorer.confirmDragAndDrop": false,
  "editor.minimap.enabled": false,
```
