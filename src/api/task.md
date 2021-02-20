---
id: task
name: Task
title: Task
tags:
    - API
---

# Task

Task is a representation of a Lua thread. It could be a Script initialization, a repeating `Tick()` function from a Script, an EventListener invocation, or a Task spawned directly by a call to `Task.Spawn()`.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `Number` | A unique identifier for the task. | Read-Only |
| `repeatCount` | `Number` | If set to a non-negative number, the Task will execute that many times. A negative number indicates the Task should repeat indefinitely (until otherwise canceled). With the default of 0, the Task will execute once. With a value of 1, the script will repeat once, meaning it will execute twice. | Read-Write |
| `repeatInterval` | `Number` | For repeating Tasks, the number of seconds to wait after the Task completes before running it again. If set to 0, the Task will wait until the next frame. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Cancel()` | `None` | Cancels the Task immediately. It will no longer be executed, regardless of the state it was in. If called on the currently executing Task, that Task will halt execution. | None |
| `GetStatus()` | `TaskStatus` | Returns the status of the Task. Possible values include: TaskStatus.UNINITIALIZED, TaskStatus.SCHEDULED, TaskStatus.RUNNING, TaskStatus.COMPLETED, TaskStatus.YIELDED, TaskStatus.FAILED, TaskStatus.CANCELED. | None |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Task.Spawn(function taskFunction, [Number delay])` | [`Task`](task.md) | Creates a new Task which will call taskFunction without blocking the current task. The optional delay parameter specifies how many seconds before the task scheduler should run the Task. By default, the scheduler will run the Task at the end of the current frame. | None |
| `Task.GetCurrent()` | [`Task`](task.md) | Returns the currently running Task. | None |
| `Task.Wait([Number delay])` | `Number, Number` | Yields the current Task, resuming in delay seconds, or during the next frame if delay is not specified. Returns the amount of time that was actually waited, as well as how long a wait was requested. | None |

## Examples

Using:

- `Spawn`
- `GetCurrent`
- `id`

You can spawn new tasks via `Task.Spawn()`, and leave them to execute without blocking your main Lua script. This has a lot of potential uses, from animation, to code organization.

This is a fairly contrived example, but it demonstrates how even if spawned tasks yield via `Task.Wait()`, it doesn't block any other tasks.

```lua
local nameMap = {}
local debug_taskLog = ""

function SpawnCountdown(name)
    local newTask = Task.Spawn(function ()
        local currentTask = Task.GetCurrent()
        local myName = nameMap[currentTask.id]
        print(myName .. ": 3...")
        Task.Wait(1)
        print(myName .. ": 2...")
        Task.Wait(1)
        print(myName .. ": 1...")
        Task.Wait(1)
        print(myName .. ": LIFTOFF!!!")
    end)
    nameMap[newTask.id] = name
    return newTask
end

local task1 = SpawnCountdown("Fred")
Task.Wait(0.5)
local task2 = SpawnCountdown("Bob")
--[[Output is:
        Fred: 3...
        Bob: 3...
        Fred: 2...
        Bob: 2...
        Fred: 1...
        Bob: 1...
        Fred: LIFTOFF!!!
        Bob: LIFTOFF!!!
    ]]
```

See also: [Task.Wait](task.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `Wait`

`Task.Wait()` is an extremely useful function that you can use to make your current Lua thread pause for an amount of time. If you provide a number as an argument, the task will yield for that many seconds. If no argument is provided, it yields until the next update frame.

It returns two numbers. The first number is how long the task was actually yielded. The second number is the requested delay when `Task.Wait()` was called.

```lua
print("Testing Task.Wait()")

local timeElapsed, timeRequested = Task.Wait(3)

print("timeElapsed = " .. timeElapsed)
print("timeRequested = " .. timeRequested)
```

See also: [CoreLua.print](coreluafunctions.md)

---

Using:

- `Cancel`
- `GetStatus`

Tasks started via `Task.Spawn()` continue until they are completed. But you can end them early, via their `Cancel()` method.

Tasks also have a `GetStatus()` method, which can be used to check on their current status - whether they are currently running, are scheduled to run in the future, or have already run to completion.

```lua
local counter = 0

-- This task will count the seconds forever.
local myTask = Task.Spawn(function()
    while true do
        print(tostring(counter) .. " seconds...")
        Task.Wait(1)
        counter = counter + 1
    end
end)

Task.Wait(4.5)
print("Current status is Scheduled? " .. tostring(myTask:GetStatus() == TaskStatus.SCHEDULED))
print(" -- Cancelling Task -- ")
myTask:Cancel()
print("Current status is Canceled? " .. tostring(myTask:GetStatus() == TaskStatus.CANCELED))
```

See also: [Task.Spawn](task.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `repeatCount`
- `repeatInterval`

You can schedule tasks to run a specific number of times, and to wait a specific number of times between repeats. This sample creates a task that prints out "hello world", and then has it repeat itself thee times, once per second.

Note that the repeat count is the number of time the task will repeat. NOT the number of times it will execute! (It will execute one more time than it repeats.)

```lua
local counter = 0

local myTask = Task.Spawn(function()
    counter = counter + 1
    print("Hello world! x" .. tostring(counter))
end)

myTask.repeatCount = 3
myTask.repeatInterval = 1

--[[
Output:
    Hello world! x1
    Hello world! x2
    Hello world! x3
    Hello world! x4
]]
```

See also: [Task.Spawn](task.md) | [CoreLua.print](coreluafunctions.md)

---
