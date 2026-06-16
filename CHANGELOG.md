## FUA Version 0.4.5 - 2026-06-16

- Fixed guard placed on prepare message. It wasnt allowing practice outside of L'ura fight.

&nbsp;

---

&nbsp;

## FUA Version 0.4.4 - 2026-06-15

- Fixed addon communication self-imports causing assignment order corruption.
- Added safeguards to ignore a player's own addon messages.
- Added protected combat restrictions for addon assignment imports.
- Send Message now automatically broadcasts addon messages outside combat.
- Prepare Message is automatically used during protected combat.
- Added combat-aware button labeling.
- Improved communication diagnostics and test coverage.
- Added safeguards against debug settings being included in release builds.

&nbsp;

---

&nbsp;

## FUA Version 0.4.3 - 2026-06-14

### Fixed

- Replaced combat chat import system with addon message communication.
- Removed raid, instance, say, and emote chat parsing to avoid combat taint errors.
- Added addon message send/receive infrastructure for future assignment synchronization.
- Improved communication debugging and diagnostics.
- Updated communication tests and import handling.
- Fixed several startup and import stability issues.

&nbsp;

---

&nbsp;

## FUA Version 0.4.2 - 2026-06-11

### Fixed

- A bug where MSG_RDY was not set for all locales.

&nbsp;

---

&nbsp;

## FUA Version 0.4.1 - 2026-06-11

### Fixed

- A debug setting was left on forcing the addon to always be in heroic.

&nbsp;

---

&nbsp;

## FUA Version 0.4.0 - 2026-06-10

### Added

* Localization framework with automatic client language detection.
* English (US) localization.
* English (UK) localization.
* Spanish (Spain) localization.
* Spanish (Latin America) localization.
* Portuguese (Brazil) localization.
* German localization.
* French localization.
* Italian localization.
* Centralized color management system.
* Centralized layout configuration system.
* Options button icon support.
* Additional UI configuration constants for future encounter support.

### Changed

* Refactored addon architecture into Core, Services, Modules, UI, and Localization components.
* Moved encounter-specific data into encounter modules.
* Centralized user-facing strings into locale files.
* Replaced hardcoded UI colors with shared color definitions.
* Replaced hardcoded UI dimensions with layout constants.
* Standardized UI element sizing and positioning.
* Improved options window localization support.
* Improved maintainability for future encounter development.
* Improved project organization and file structure.

### Fixed

* SavedVariables initialization and startup loading issues.
* UI state restoration on login and reload.
* Localization loading order issues.
* Multiple UI constant and layout reference issues discovered during refactoring.
* Various hardcoded text and color references throughout the addon.

### Developer Notes

* Established module structure for future raid and encounter support.
* Added framework components for future settings, localization, and shared services expansion.

&nbsp;

---

&nbsp;

## Version 0.3.0 - 2026-06-9

### New Features

- Chat Assignment Import
- Assignment Priority System
- Encounter Validation
- Assignment Import Feedback
- Compact Diagram Mode
- Collapsed mode displays
- Persistent Collapse State

### UI Improvements

- Full-Width Layout Divider
- Option Button Visual Refresh
- Control Layout Refactor

### Developer Improvements

- Added a standalone Lua test framework for validating addon logic outside of World of Warcraft.
- Added project testing standards, test organization guidelines and execution instructions.

Automated tests now cover:

* Data definitions
* Assignment ordering
* Chat message preparation
* Communication parsing
* Assignment import rules
* Encounter state management
* Slash commands
* Addon initialization

### Internal Changes

- Communication System Foundation
- Assignment Parsing Engine
- Import Source Tracking
- Runtime State Improvements

&nbsp;

---

&nbsp;

## FUA 0.2.0 - 2026-06-8

Major visual update for the Midnight Falls encounter helper.

### New Features

- Added encounter diagram with visual player position assignments.
- Added custom L'ura artwork and encounter-themed layout.
- Added difficulty-aware position displays.
  - LFR / Normal: 3-position layout
  - Heroic / Mythic: 5-position layout
- Added visual rune assignment tracking.
- Added dedicated options panel.
- Added settings access from the main window.

### Improvements

- Improved overall UI layout and spacing.
- Improved visual hierarchy and readability.
- Reduced interface clutter during encounters.
- Improved rune icon presentation.
- Improved assignment preview workflow.

### Quality of Life

- Input display now reflects the exact order entered by the player.
- Encounter diagram displays final strategy positioning separately from input order.
- Added developer difficulty override support for testing.

&nbsp;

---

&nbsp;

## FUA 0.1.0

Initial public release.

### Features

- Rune assignment helper for the Midnight Falls encounter.
- Supports Character and Raid Marker output modes.
- Supports Clockwise and Counter Clockwise ordering.
- Automatic difficulty detection.
- Duplicate symbol prevention.
- Automatic encounter detection.
- Movable user interface.
- Persistent window position.
- Persistent user preferences.

### Communication

- Generates formatted rune assignment messages.
- Supports manual review before sending.
- Designed to remain compliant with Blizzard addon restrictions.
