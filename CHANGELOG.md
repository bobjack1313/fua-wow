# FUA Version 0.4.0 - 2026-06-11

## Added

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

## Changed

* Refactored addon architecture into Core, Services, Modules, UI, and Localization components.
* Moved encounter-specific data into encounter modules.
* Centralized user-facing strings into locale files.
* Replaced hardcoded UI colors with shared color definitions.
* Replaced hardcoded UI dimensions with layout constants.
* Standardized UI element sizing and positioning.
* Improved options window localization support.
* Improved maintainability for future encounter development.
* Improved project organization and file structure.

## Fixed

* SavedVariables initialization and startup loading issues.
* UI state restoration on login and reload.
* Localization loading order issues.
* Multiple UI constant and layout reference issues discovered during refactoring.
* Various hardcoded text and color references throughout the addon.

## Developer Notes

* Established module structure for future raid and encounter support.
* Added framework components for future settings, localization, and shared services expansion.

---

# Version 0.3.0

## New Features

### Chat Assignment Import

FUA can now read assignment strings posted in chat and automatically populate the assignment order and diagram.

Supported channels:

* Raid Warning
* Raid Chat
* Instance Chat

Supported formats:

* Character output (`[ X ] [ T ] [ O ]`)
* Marker output (`[ {rt7} ] [ {rt1} ] [ {rt2} ]`)

### Assignment Priority System

Imported assignments now follow a priority hierarchy:

1. Raid Warning
2. Raid Chat
3. Instance Chat

Higher-priority assignments override lower-priority assignments automatically.

Assignments from the same priority level may overwrite previous assignments, allowing raid leaders to quickly correct mistakes.

### Encounter Validation

Chat assignment imports are only accepted while the Midnight Falls encounter is active.

This prevents unrelated chat messages from triggering assignment updates outside the encounter.

### Assignment Import Feedback

FUA now provides confirmation when an assignment is successfully imported from chat.

### Compact Diagram Mode

Added a collapsible interface mode for players who only need to view assignments.

Collapsed mode displays:

* Diagram
* Expand button
* Quick Clear button

Expanded mode retains the full assignment creation interface.

### Persistent Collapse State

FUA now remembers whether the interface was expanded or collapsed between sessions.

---

## UI Improvements

### Full-Width Layout Divider

Updated divider behavior and layout structure to better support expanded and collapsed interface modes.

### Option Button Visual Refresh

Improved option button state indicators for better readability and visual consistency.

### Control Layout Refactor

Reorganized controls into dedicated compact and full-control sections to support future interface enhancements.

### Added Commands

Added help and version commands.

---

## Developer Improvements

### Automated Test Framework

Added a standalone Lua test framework for validating addon logic outside of World of Warcraft.

### Test Coverage Added

Automated tests now cover:

* Data definitions
* Assignment ordering
* Chat message preparation
* Communication parsing
* Assignment import rules
* Encounter state management
* Slash commands
* Addon initialization

### Testing Documentation

Added project testing standards, test organization guidelines, and execution instructions.

---

## Internal Changes

### Communication System Foundation

Added communication infrastructure to support both chat-based assignment sharing and future addon-message integration.

### Assignment Parsing Engine

Implemented reusable parsing logic for assignment detection, validation, and import processing.

### Import Source Tracking

Added internal assignment source priority tracking to support safe assignment overrides.

### Runtime State Improvements

Expanded runtime state management for encounter tracking, import handling, and UI persistence.

---

# FUA 0.2.0

Major visual update for the Midnight Falls encounter helper.

New Features

• Added encounter diagram with visual player position assignments.
• Added custom L'ura artwork and encounter-themed layout.
• Added difficulty-aware position displays.

* LFR / Normal: 3-position layout
* Heroic / Mythic: 5-position layout

• Added visual rune assignment tracking.
• Added dedicated options panel.
• Added settings access from the main window.

Improvements

• Improved overall UI layout and spacing.
• Improved visual hierarchy and readability.
• Reduced interface clutter during encounters.
• Improved rune icon presentation.
• Improved assignment preview workflow.

Quality of Life

• Input display now reflects the exact order entered by the player.
• Encounter diagram displays final strategy positioning separately from input order.
• Added developer difficulty override support for testing.

No gameplay automation has been added. FUA continues to function as a player-controlled communication and coordination tool.

---

# FUA 0.1.0

Initial public release.

## Features

* Rune assignment helper for the Midnight Falls encounter.
* Supports Character and Raid Marker output modes.
* Supports Clockwise and Counter Clockwise ordering.
* Automatic difficulty detection.

  * LFR / Normal: 3 symbols
  * Heroic / Mythic: 5 symbols
* Duplicate symbol prevention.
* Automatic encounter detection.
* Movable user interface.
* Persistent window position.
* Persistent user preferences.
* Lightweight and player-controlled design.

## Communication

* Generates formatted rune assignment messages.
* Supports manual review before sending.
* Designed to remain compliant with Blizzard addon restrictions.

## Commands

* `/fua`
* `/fua show`
* `/fua hide`
* `/fua clear`

## Notes

FUA is designed as a communication aid and does not automate gameplay decisions or automatically send chat messages.
