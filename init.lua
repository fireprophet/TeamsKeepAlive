local maxIterations = 1000000  -- Set a very large number of iterations
local currentIteration = 0

-- Timer with delay between iterations
local function executeTask()
    -- Increment iteration counter
    currentIteration = currentIteration + 1
    hs.printf("Iteration number: %d", currentIteration)  -- Print the current iteration in the console

    -- Check for Microsoft Teams windows
    local allWindows = hs.window.allWindows()

    for _, win in ipairs(allWindows) do
        if string.match(win:title(), "Microsoft Teams") then
            hs.printf("Microsoft Teams window found on iteration %d", currentIteration)

            -- Focus on the Microsoft Teams window
            win:focus()

            -- Simulate pressing the Shift key
            hs.eventtap.keyStroke({}, "shift")
            hs.printf("Shift key pressed on iteration %d", currentIteration)

            -- Move the mouse by 1 pixel and back
            local currentMousePosition = hs.mouse.getRelativePosition()
            hs.mouse.setRelativePosition({x = currentMousePosition.x + 1, y = currentMousePosition.y})
            hs.mouse.setRelativePosition(currentMousePosition)
            hs.printf("Mouse moved on iteration %d", currentIteration)

            break -- Exit loop once Teams is found
        end
    end

    -- Check if the maximum number of iterations has been reached
    if currentIteration < maxIterations then
        -- Schedule the next call with a slight delay (to avoid timeouts)
        hs.timer.doAfter(10, executeTask)
    else
        hs.printf("Timer stopped after %d iterations", currentIteration)
    end
end

-- Start the first call
hs.timer.doAfter(10, executeTask)
