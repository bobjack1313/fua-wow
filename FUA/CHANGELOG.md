# FUA 0.2.0

Major visual redesign update.

## User Interface

* New encounter diagram layout.

* Added central L'ura portrait display.

* Added dynamic position visualization.

* Added difficulty-aware position layouts.

  * LFR / Normal displays positions 3, 2, 1.
  * Heroic / Mythic displays positions 5, 4, 3, 2, 1.

* Added visual rune assignment display.

* Improved spacing and visual hierarchy.

* Added diagram divider and layout refinements.

* Moved strategy controls into a dedicated options panel.

* Added settings button access from the main window.

## Visual Improvements

* Updated rune button presentation.
* Improved rune icon artwork integration.
* Added custom encounter artwork support.
* Improved symbol readability and display formatting.
* Reduced visual clutter in the primary workflow.

## Quality of Life

* Display order now reflects player input sequence.
* Encounter diagram reflects strategy order independently.
* Improved preparation message workflow.
* Added developer difficulty override support for testing.

## Notes

This release focuses on visual presentation, encounter visualization, and overall usability improvements. Core functionality and communication behavior remain unchanged.


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
