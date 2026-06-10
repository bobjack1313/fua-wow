# FUA Testing Standards

## Purpose

The FUA test suite validates addon behavior outside of World of Warcraft whenever possible. Logic, parsing, state management, and data transformations should be covered by automated tests. UI behavior should be manually verified unless isolated into pure functions.

---

## Directory Structure

```text
fua-wow/
├─ FUA/
│  └─ Addon source files
├─ tests/
│  ├─ wow_stubs.lua
│  ├─ test_runner.lua
│  ├─ test_data.lua
│  ├─ test_order.lua
│  ├─ test_chat.lua
│  ├─ test_communication.lua
│  ├─ test_encounter.lua
│  ├─ test_commands.lua
│  ├─ test_init.lua
│  └─ ui/
│      └─ manual_test_checklist.md
├─ scripts/
│  └─ run-tests.sh
└─ docs/
   └─ testing.md
```

Test files must never be packaged with the addon.

---

## General Rules

* One test file per addon file whenever practical.
* Test behavior, not implementation details.
* Tests must be independent and repeatable.
* Avoid shared mutable state between tests.
* Use WoW API stubs for non-WoW execution.
* Prefer pure functions whenever possible.
* Keep tests small and focused on a single behavior.
* Every bug fixed should eventually receive a regression test.

---

## File Headers

All test files should include a standard header.

```lua
-----------------------------------------------------------------------
-- FUA Tests
-- File: test_order.lua
--
-- Tests:
--   * Order insertion
--   * Duplicate prevention
--   * Symbol limit enforcement
--   * Undo behavior
--   * Clear behavior
-----------------------------------------------------------------------
```

---

## Test Structure

```lua
-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Test Data
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------
```

---

## Current Automated Coverage

### test_data.lua

* Default configuration
* Encounter constants
* Symbol definitions
* Marker mappings

### test_order.lua

* Symbol insertion
* Duplicate prevention
* Symbol limits
* Undo behavior
* Clear behavior
* Display formatting
* Chat formatting
* Reverse order logic

### test_chat.lua

* Chat prefix selection
* Group channel routing
* Prepared message generation
* Empty message handling

### test_communication.lua

* Symbol token lookup
* Character assignment parsing
* Marker assignment parsing
* Invalid message rejection
* Import priority handling

### test_encounter.lua

* Difficulty detection
* Symbol count selection
* Encounter activation
* Encounter deactivation
* Import priority reset

### test_commands.lua

* Slash command registration
* Show command
* Hide command
* Clear command
* Toggle behavior

### test_init.lua

* SavedVariables initialization
* Runtime configuration loading
* Startup initialization
* Addon message prefix registration

---

## Manual Verification Checklist

The following areas are currently verified manually:

### Main Frame

* Window creation
* Window dragging
* Position persistence
* Show/hide behavior

### Diagram

* Lu'a artwork
* Position slot placement
* 3-position layout
* 5-position layout
* Symbol rendering

### Controls

* Symbol buttons
* Undo button
* Clear button
* Prepare Message button

### Options

* Output mode switching
* Strategy direction switching
* SavedVariables persistence

### Encounter Testing

* Midnight Falls pull behavior
* Difficulty detection in live raid
* Chat import behavior
* Raid Warning priority handling

---

## Running Tests

Run all automated tests:

```bash
./scripts/run-tests.sh
```

Run an individual suite:

```bash
lua tests/test_order.lua
```

---

## Future Coverage Targets

Potential future automated tests:

* SavedVariables persistence integration
* Chat import end-to-end flow
* Communication transport layer
* Release packaging validation
* TOC validation
* Texture existence verification

---

## Goal

Every bug that can be reproduced outside the game should eventually have a corresponding automated test.
