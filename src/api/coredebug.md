---
id: coredebug
name: CoreDebug
title: CoreDebug
tags:
    - API
---

# CoreDebug

The CoreDebug namespace contains functions that may be useful for debugging.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreDebug.DrawLine(Vector3 start, Vector3 end, [table optionalParameters])` | `None` | Draws a debug line. `optionalParameters: duration (Number), thickness (Number), color (Color)`. 0 or negative duration results in a single frame. | None |
| `CoreDebug.DrawBox(Vector3 center, Vector3 dimensions, [table optionalParameters])` | `None` | Draws a debug box, with dimension specified as a vector. `optionalParameters` has same options as `DrawLine()`, with addition of: `rotation (Rotation)` - rotation of the box. | None |
| `CoreDebug.DrawSphere(Vector3 center, radius, [table optionalParameters])` | `None` | Draws a debug sphere. `optionalParameters` has the same options as `DrawLine()`. | None |
| `CoreDebug.GetTaskStackTrace([Task task])` | `string` | Returns a stack trace listing the Lua method calls currently in progress by the given Task. Defaults to the current Task if `task` is not specified. | None |
| `CoreDebug.GetStackTrace()` | `string` | Returns a stack trace listing all actively executing Lua tasks and their method calls. Usually there is only one task actively executing at a time, with others in a yielded state and excluded from this trace. Multiple tasks can be included in the trace is one task triggers an event that has listeners registered, or if a task calls `require()` to load a new script. | None |

## Examples

Using:

- `DrawLine`
- `DrawBox`
- `DrawSphere`

Core contains several useful functions for drawing in the 3d world, that are intended for use when debugging. If you are trying to visualize values in a 3d world,

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local myProjectile = Projectile.Spawn(propCubeTemplate,
    Vector3.New(500, 0, 200), -- starting position
    Vector3.New(0, 1, 1))     -- direction
myProjectile.speed = 500
myProjectile.lifeSpan = 3
myProjectile.gravityScale = 0.25

-- This function will draw some debug graphics around the projectile ever 1/10 second:
Task.Spawn(function()
    while Object.IsValid(myProjectile) do
        local pos = myProjectile:GetWorldPosition();
        CoreDebug.DrawSphere(pos , 50, {
            duration = 2,
            color = Color.GREEN
        })

        CoreDebug.DrawLine(pos, pos  + myProjectile:GetWorldTransform():GetForwardVector() * 50, {
            duration = 2,
            color = Color.WHITE,
            thickness = 3
        })

        CoreDebug.DrawBox(pos, Vector3.New(50), {
            duration = 2,
            color = Color.BLUE,
            thickness = 3
        })

        Task.Wait(0.1)
    end
end)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [Projectile.Spawn](projectile.md) | [Vector3.New](vector3.md) | [Task.Spawn](task.md) | [Object.IsValid](object.md) | [Color.GREEN](color.md) | [Transform.GetForwardVector](transform.md)

---

Using:

- `GetTaskStackTrace`
- `GetStackTrace`

When debugging, it can often be useful to see exactly which code is executing, and which code called it. You a "stack trace" will give you this information. It is a list of every function on the call stack.

This sample shows how to get and print out the stack traces. They will be slightly different depending on which thread is examining them.

```lua
local taskStackTrace
local otherTaskStackTrace
local generalStackTrace

function Function_A()
    Function_B()
end

function Function_B()
    Function_C()
end

function Function_C()
    taskStackTrace = CoreDebug.GetTaskStackTrace()
    Task.Wait(1)
end

local otherTask = Task.Spawn(Function_A)
Task.Wait()

otherTaskStackTrace = CoreDebug.GetTaskStackTrace(otherTask)
generalStackTrace = CoreDebug.GetStackTrace()

Task.Wait(1)
print("Stack trace, as viewed from within the task:")
print(taskStackTrace)
print("Stack trace, as viewed from the main thread:")
print(otherTaskStackTrace)
print("General stack trace:")
print(generalStackTrace)
```

See also: [Task.Spawn](task.md) | [CoreLua.print](coreluafunctions.md)

---
