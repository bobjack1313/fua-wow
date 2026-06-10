#!/usr/bin/env bash
set -euo pipefail

lua tests/test_communication.lua
lua tests/test_order.lua
lua tests/test_chat.lua
lua tests/test_encounter.lua
lua tests/test_commands.lua
lua tests/test_data.lua
lua tests/test_init.lua
