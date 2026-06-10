local tests = {}

function test(name, fn)
    table.insert(tests, { name = name, fn = fn })
end

function assertEqual(actual, expected, message)
    if actual ~= expected then
        error((message or "assertEqual failed") ..
            "\nexpected: " .. tostring(expected) ..
            "\nactual:   " .. tostring(actual), 2)
    end
end

function assertTrue(value, message)
    if not value then
        error(message or "assertTrue failed", 2)
    end
end

function assertNil(value, message)
    if value ~= nil then
        error((message or "assertNil failed") ..
            "\nactual: " .. tostring(value), 2)
    end
end

function runTests()
    local passed = 0

    for _, t in ipairs(tests) do
        local ok, err = pcall(t.fn)

        if ok then
            print("PASS " .. t.name)
            passed = passed + 1
        else
            print("FAIL " .. t.name)
            print(err)
        end
    end

    print("")
    print(passed .. "/" .. #tests .. " tests passed")

    if passed ~= #tests then
        os.exit(1)
    end
end
