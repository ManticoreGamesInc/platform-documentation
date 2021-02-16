---
id: contexts
name: Contexts
title: Contexts
tags:
    - API
    - Reference
---

# Contexts

In Core, contexts are like folders and exist in one of two states: networked and non-networked. You can nest multiple contexts but only the outermost one has any effect. Inside of it, every child context acts like a folder.

When a script spawns an object, it inherits the script's context, even if it is somewhere else in the hierarchy. This means that a script in a server context can never spawn objects that clients can see or interact with.

There are five types of contexts, **Client Context**, **Non-Networked**, **Static Context**, **Server Context** and **Networked**.

## Overview

|                    | **Default (Non-Networked)** | **Networked**        | **Client Context** | **Server Context** | **Static Context** |
| ------------------ | ----------------------------| ---------------------| -------------------| -------------------| -------------------|
| Objects can change | No                          | Yes (only by server) | Yes                | Yes                | No                 |
| Collision          | Yes                         | Yes                  | No                 | No                 | Yes                |
| Objects exist on   | Client and Server           | Client and Server    | Client             | Server             | Client and Server  |
| Scripts run on     | Server                      | Server               | Client             | Server             | Client and Server  |

## Default (Non-Networked)

- Cannot change.
- Can have collision.
- Seen by server and client.
- Scripts run on the server only.

## Networked

- Can be changed by the server.
- Clients will see those changes.
- Scripts run on the server only.

## Client Context

- Objects can change.
- Objects will block any cameras unless explicitly set otherwise.
- Scripts can access "Default" or "Networked" scripts because they occupy a place in the hierarchy.
- Scripts can see "Default" or "Networked" objects because they occupy a place in the hierarchy.

## Server Context

- Objects do not have collision.
- Objects inside get removed from the client-side copy of the game sent to players.
- Provides a safeguard for creators if they want to conceal game logic.
- Scripts run on the server only.

## Static Context

- Almost like the default state (non-networked).
- Scripts can spawn objects inside a static context.
- Scripts run on both the server and the client.
- Useful for things reproduced easily on the client and server with minimal data (procedurally generated maps).
    - Send a single networked value to synchronize the server and client's random number generators.
    - Saves hundreds of transforms being sent from the server to every client.

!!! warning "Beware of de-sync issues!"
    Performing any operations from a static context that might diverge during server/client execution of a script will almost certainly cause de-sync issues.
    Static scripts are run independently on the server and all clients so you should avoid performing any script actions that can exhibit different behavior depending on the machine. Specifically, avoid any logic that is conditional on:
    - Server-only or client-only objects.
    - Random number generators with different seeds.
    - Logic based around local `time()`.
