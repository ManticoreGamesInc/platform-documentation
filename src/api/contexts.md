---
id: contexts
name: Contexts
title: Contexts
tags:
    - API
    - Reference
---

# Contexts

## Overview

In Core, contexts are like folders and exist in one of two states: networked and non-networked. Contexts manage its children so they know to spawn on the server and/or client. It also dictates if the children can be changed or deleted after they are spawned.

## Context Types

There are six types of contexts, **Client Context**, **Non-Networked**, **Static Context**, **Server Context**, **Networked** and **Local Context**.

|                    | **Default (Non-Networked)** | **Networked**        | **Client Context** | **Server Context** | **Static Context** | **Local Context**  |
| ------------------ | ----------------------------| ---------------------| -------------------| -------------------| -------------------| -------------------|
| Objects can change | No                          | Yes (only by server) | Yes                | Yes                | No                 | Yes                |
| Collision          | Yes                         | Yes                  | No                 | No                 | Yes                | Yes                |
| Objects exist on   | Client and Server           | Client and Server    | Client             | Server             | Client and Server  | Client and Server  |
| Scripts run on     | Server                      | Server               | Client             | Server             | Client and Server  | Client and Server  |

### Default (Non-Networked)

- Cannot change.
- Can have collision.
- Seen by server and client.
- Scripts run on the server only.

### Networked

- Can be changed by the server.
- Clients will see those changes.
- Scripts run on the server only.

### Client Context

- Objects can change.
- Objects will block any cameras unless explicitly set otherwise.
- Scripts can access "Default" or "Networked" scripts because they occupy a place in the hierarchy.
- Scripts can see "Default" or "Networked" objects because they occupy a place in the hierarchy.

### Server Context

- Objects do not have collision.
- Objects inside get removed from the client-side copy of the game sent to players.
- Provides a safeguard for creators if they want to conceal game logic.
- Scripts run on the server only.

### Static Context

- Almost like the default state (non-networked).
- Scripts can spawn objects inside a static context.
- Scripts run on both the server and the client.
- Useful for things reproduced easily on the client and server with minimal data (procedurally generated maps).
    - Send a single networked value to synchronize the server and client's random number generators. Avoid using `math.random` for this purpose as this is shared by all scripts and contexts and will not generate the same sequence of numbers per client. See [RandomStream](../api/randomstream.md)
    - Saves hundreds of transforms being sent from the server to every client.

### Local Context

- The same as **Static Context** but objects can change.
- Scripts can spawn objects inside a local context.
- Scripts run on both the server and the client.

!!! warning "Beware of de-sync issues!"
    Performing any operations from a static context that might diverge during server/client execution of a script will almost certainly cause de-sync issues.
    Static scripts are run independently on the server and all clients so you should avoid performing any script actions that can exhibit different behavior depending on the machine. Specifically, avoid any logic that is conditional on:
    - Server-only or client-only objects.
    - Random number generators with different seeds.
    - Logic based around local `time()`.

## Nested Contexts

You can nest multiple contexts; however, the outermost context is usually the only one that takes effect. There are two exceptions in which the child context is respected within a different context. The first is a child client or server context inside a static context. The second is child client or server context inside a local context. In all other cases, the child context is treated as a folder.

## Context for Spawned Object

When a script spawns an object, the object inherits the script's context by default. The [World.SpawnAsset](../api/world.md) function allows an optional parameter to set the spawned object's context. There are restrictions on setting an object's context such as spawning client only objects from a server script or networked objects from a client script. If an invalid context is specified, an error will be raised.

## Learn More

[Networking Reference](../references/networking.md)
