---
id: equipment
name: Equipment
title: Equipment
---

# Equipment

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `CanEquipmentInteract(Player, CoreObject, string, table)` | `string`, `boolean` | Returns true if the registered target can interact with the equipment. Also returns a reason the target cannot be interacted with if relevant. | None |
| `Equip(Player, string, string)` | `None` | Equips an item to a Player, or toggles an already equipped item off. On the server this returns a reference to the Equipment if it was equipped. | None |
| `EquipmentInteract(Player, CoreObject, string, table)` | `string`, `boolean` | Interacts with a registered target with a specific equipment. Returns success and error information. | None |
| `FindEquipmentTargetByAncestors(CoreObject)` | `CoreObject` | Will traverse up the hierarchy from the supplied CoreObject and return the first registered target or nil. | None |
| `GetAllEquipment(Player)` | `table` | Returns all equipped Equipment for a Player. | None |
| `GetDefaultTool(Player)` | `Ability` | Returns the default tool for a Player if there is one. | None |
| `GetEquipment(Player, string)` | `None` | Returns Equipment for the template if it is currently equipped. | None |
| `GetEquipmentSettings(CoreObject, table)` | `table` | Returns an equipmentSettings table. | None |
| `GetInteractionTarget(CoreObject, Script, string, table)` | `string`, `CoreObject` | Returns a registered equipment target if one is currently a potential target in the provided Interaction System Module and the equipment target can be interacted with. Also returns a reason a target could not be found if relevant. | None |
| `GetSetting(EquipmentSetting)` | `any` | Returns a setting value. | None |
| `GetTargets()` | `table` | Returns all registered equipment targets. | None |
| `IsEquipmentTarget(CoreObject)` | `boolean` | Returns true if the target is registered for interactions. | None |
| `IsEquipped(Player, string)` | `None` | Returns true if the template is currently equipped. | None |
| `IsValidToolType(string, string, table)` | `boolean` | Returns true if the supplied tool type exists in the list of valid types. | None |
| `RegisterEquipmentTarget(CoreObject, table)` | `None` | Registers an object for equipment interactions with Basic and Advanced Equipment. The function table must include the following data: {    CanEquipmentInteract = function(player, target, toolType, equipmentSettings),    EquipmentInteract = function(player, target, toolType, equipmentSettings) } | None |
| `SpawnEquipment(string, CoreObject|nil, Vector3|nil, Rotation|nil)` | `None` | Spawns an Equipment in the world. | None |
| `ToggleHandOutline(boolean)` | `None` | Determines whether the default Hand Tool outlining effect is active or not. | None |
| `Unequip(Player, string)` | `None` | Unequips an item from a Player. | None |
| `UnequipAll(Player)` | `None` | Unequips all items from a Player. | None |
| `UnregisterEquipmentTarget(CoreObject)` | `None` | Stops equipment from being able to interact with the target. | None |
| `Update(number)` | `None` | Runs each frame. | None |
| `UpdateSettings(EquipmentSettings)` | `None` | Updates the current settings with a new set. | None |
