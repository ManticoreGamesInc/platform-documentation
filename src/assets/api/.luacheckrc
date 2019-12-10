stds.core = {
    read_globals = {
        -- Namespaces
        "CoreDebug",
        "CoreMath",
        "Events",
        "Game",
        "Storage",
        "Teams",
        "UI",
        "World",
        -- Types
        "Ability",
        "AbilityPhaseSettings",
        "AbilityTarget",
        "AbilityUIControl",
        "AreaLight",
        "Audio",
        "ButtonUIControl",
        "Camera",
        "CanvasUIControl",
        "Color",
        "CoreObject",
        "CoreObjectReference"
        "Damage",
        "Equipment",
        "Event",
        "EventListener",
        "Folder",
        "Game",
        "HitResult",
        "ImageUIControl",
        "Light",
        "MovementSettings",
        "NetworkContext",
        "Object",
        "PanelUIControl",
        "PerPlayerReplicator",
        "Player",
        "PlayerStart",
        "PointLight",
        "ProgressBarUIControl",
        "Projectile",
        "Quaternion",
        "RandomStream",
        "Replicator",
        "Rotation",
        "Script",
        "SpotLight",
        "SmartAudio",
        "SmartObject",
        "StaticMesh",
        "Task",
        "Terrain",
        "TextUIControl",
        "Transform",
        "Trigger",
        "UIControl",
        "Vector2",
        "Vector3",
        "Vector4",
        "Vfx",
        "Weapon",
        "WeaponInteraction",
        "WorldText",
    }
}

std = "lua53+core"
max_line_length = false
exclude_files = {
	".luacheckrc"
}

ignore = {
	"211", -- Unused local variable
	"212", -- Unused argument
	"213", -- Unused loop variable
	-- "231", -- Set but never accessed
	"311", -- Value assigned to a local variable is unused
	"314", -- Value of a field in a table literal is unused
	"42.", -- Shadowing a local variable, an argument, a loop variable.
	"43.", -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
	"542", -- An empty if branch
}

globals = {
	"_G",
}
