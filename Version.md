# Version History

## Version 2.9 

**Release Date: 2026-07-20**

This version migrates optimization features and bug fixes from the MailMaven template script into the main Apple Mail export script:

- **Reply Subdivision (`sub-divide-replies`)**: Added support for subdividing thread replies by inserting horizontal rule separators (`_________________________`) before `From:` boundaries when enabled.
- **Smart Linkifier Upgrade (v2.9)**:
  - Excluded email domain suffixes (preceded by `@`) from being erroneously linkified.
  - Normalized Unicode Line Separators (`\u2028`) and Paragraph Separators (`\u2029`) to standard newlines.
- **Date Formatting Refactoring**: Extracted inline date padding and parsing logic into a clean, reusable `formatDate` helper handler.
- **Filename Sanitization Upgrades**:
  - Forbidden filesystem characters are now replaced with `" - "` instead of `_`.
  - Collapsed duplicate spaces and trimmed trailing/leading spaces.
- **YAML Frontmatter Title Safety**: Used the sanitized `safeSubject` value instead of raw `msgSubject` in frontmatter titles to avoid Obsidian parsing errors.
- **Robust File Saving**: Swapped standard AppleScript file stream handling for shell-redirection-based writing (`printf %s ... > ...`), preventing write-locks and descriptor leaks.

## Version 2.8 (Previous)

All versions prior to version 2.9 have been documented in the [README.md](file:///Volumes/CrucialX8/git/Personal/applemail-to-obsidian/README.md) file.
