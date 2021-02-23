---
id: randomstream
name: RandomStream
title: RandomStream
tags:
    - API
---

# RandomStream

Seed-based random stream of numbers. Useful for deterministic RNG problems, for instance, inside a Client Context so all players get the same outcome without the need to replicate lots of data from the server. Bad quality in the lower bits (avoid combining with modulus operations).

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `RandomStream.New([integer seed])` | [`RandomStream`](randomstream.md) | Constructor with specified seed, defaults to a random value. | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `seed` | `integer` | The current seed used for RNG. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetInitialSeed()` | `integer` | The seed that was used to initialize this stream. | None |
| `Reset()` | `None` | Function that sets the seed back to the initial seed. | None |
| `Mutate()` | `None` | Moves the seed forward to the next seed. | None |
| `GetNumber([number min, number max])` | `number` | Returns a floating point number between `min` and `max` (inclusive), defaults to `0` and `1` (exclusive). | None |
| `GetInteger(integer min, integer max)` | `number` | Returns an integer number between `min` and `max` (inclusive). | None |
| `GetVector3()` | [`Vector3`](vector3.md) | Returns a random unit vector. | None |
| `GetVector3FromCone(Vector3 direction, number halfAngle)` | [`Vector3`](vector3.md) | Returns a random unit vector, uniformly distributed, from inside a cone defined by `direction` and `halfAngle` (in degrees). | None |
| `GetVector3FromCone(Vector3 direction, number horizontalHalfAngle, number verticalHalfAngle)` | [`Vector3`](vector3.md) | Returns a random unit vector, uniformly distributed, from inside a cone defined by `direction`, `horizontalHalfAngle` and `verticalHalfAngle` (in degrees). | None |
