--[[
	CORE API Definition for ZeroBraneStudio https://studio.zerobrane.com/

	Types are named with _ in front by convention in this file (_
	when exact table types cannot be deducted, you can use type definitions to trigger auto complete as workaround. for example,

	-- trigger would be treated as a coreobject table, but not trigger table
	local trigger = script.parent

	-- you can type _trigger to have correct auto complete show up, not ideal but a work around
	_trigger.on_begin_overlap(_player, _trigger, etc)

	ZeroBrane API Reference: https://studio.zerobrane.com/doc-api-auto-complete
]]

local function def_coreObject()
return {
	type = "class",
	description = "core object",
	childs = {
		name = {
			type = "value",
			description = "object name (dynamic)",
			valuetype = "string",
		},
		id = {
			type = "value",
			description = "muid",
			valuetype = "number",
		},
		isVisible = {
			type = "value",
			description = "(dynamic)",
			valuetype = "boolean",
		},
		isCollidable = {
			type = "value",
			description = "(dynamic)",
			valuetype = "boolean",
		},
		isEnabled = {
			type = "value",
			description = "(dynamic)",
			valuetype = "boolean",
		},
		isStatic = {
			type = "value",
			description = "if true, cannot call dynamic functions or modify dynamic properties. read-only",
			valuetype = "boolean",
		},
		isNetworked = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isClientOnly = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isServerOnly = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isDisconnected = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		lifeSpan = {
			type = "value",
			description = "duration after which the object is destroyed",
			valuetype = "number",
		},
		userData = {
			type = "value",
			description = "table in which user can store any data they want",
			valuetype = "table",
		},
		parent = {
			type = "value",
			description = "parent core object (dynamic)",
			valuetype = "_coreObject",
		},
		sourceTemplateId  = {
			type = "value",
			description = "The ID of the Template from which this Core Object was instantiated. nil if the object did not come from a Template",
			valuetype = "string",
		},

		childAddedEvent = {
			type = "value",
			description = "event(parentObject, newChildObject): fires when a child is added to this object",
			valuetype = "_eventType",
		},
		childRemovedEvent = {
			type = "value",
			description = "event(parentObject, removedChildObject): fires when a child is removed from this object",
			valuetype = "_eventType",
		},
		descendantAddedEvent = {
			type = "value",
			description = "event(ancestor, newObject): fires when a child is added to this object or its descendant",
			valuetype = "_eventType",
		},
		descendantRemovedEvent = {
			type = "value",
			description = "event(ancestor, newObject): fires when a child is removed from this object or its descendant",
			valuetype = "_eventType",
		},
		destroyEvent = {
			type = "value",
			description = "event(coreobject): fires when an object is about to be destroyed",
			valuetype = "_eventType",
		},

		GetTransform = {
			type = "method",
			args = "()",
			returns = "(transform)",
			valuetype = "_transform",
			description = "get local transform",
		},
		SetTransform = {
			type = "method",
			args = "(transform: transform)",
			returns = "()",
			valuetype = "",
			description = "set local transform",
		},
		GetPosition = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "return local position",
		},
		SetPosition = {
			type = "method",
			args = "(vector)",
			returns = "()",
			valuetype = "",
			description = "set local position",
		},
		GetRotation = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "get local rotation",
		},
		SetRotation = {
			type = "method",
			args = "(rotation)",
			returns = "()",
			valuetype = "",
			description = "set local rotation",
		},
		GetScale = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "get local scale",
		},
		SetScale = {
			type = "method",
			args = "(vector)",
			returns = "()",
			valuetype = "",
			description = "set local scale",
		},
		GetWorldTransform = {
			type = "method",
			args = "()",
			returns = "(transform)",
			valuetype = "_transform",
			description = "get world transform",
		},
		SetWorldTransform = {
			type = "method",
			args = "(transform: transform)",
			returns = "()",
			valuetype = "",
			description = "set world transform",
		},
		GetWorldPosition = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "return world position",
		},
		SetWorldPosition = {
			type = "method",
			args = "(vector : position)",
			returns = "()",
			valuetype = "",
			description = "set world position",
		},
		GetWorldRotation = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "get world rotation",
		},
		SetWorldRotation = {
			type = "method",
			args = "(rotation : rotation)",
			returns = "()",
			valuetype = "",
			description = "set world rotation",
		},
		GetWorldScale = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "get world scale",
		},
		SetWorldScale = {
			type = "method",
			args = "(vector: scale)",
			returns = "()",
			valuetype = "",
			description = "set world scale",
		},
		GetVelocity = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "current velocity",
		},
		SetVelocity = {
			type = "method",
			args = "(vector: velocity)",
			returns = "()",
			valuetype = "",
			description = "set velocity",
		},
		GetAngularVelocity = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "",
		},
		SetAngularVelocity = {
			type = "method",
			args = "(vector)",
			returns = "()",
			valuetype = "",
			description = "",
		},
		IsVisibleInHierarchy = {
			type = "method",
			args = "()",
			returns = "(boolean)",
			valuetype = "boolean",
			description = "",
		},
		IsCollidableInHierarchy = {
			type = "method",
			args = "()",
			returns = "(boolean)",
			valuetype = "boolean",
			description = "",
		},
		IsEnabledInHierarchy = {
			type = "method",
			args = "()",
			returns = "(boolean)",
			valuetype = "boolean",
			description = "",
		},
		GetChildren = {
			type = "method",
			args = "()",
			returns = "(table)",
			valuetype = "table",
			description = "",
		},
		AttachToPlayer = {
			type = "method",
			args = "(player: player, socket: string)",
			returns = "()",
			description = "attach to player at given socket. Object will be unparented from current hierarchy, and its parent will be nil",
		},
		AttachToPlayerCamera = {
			type = "method",
			args = "(player: player)",
			returns = "()",
			description = "attach to player's camera component",
		},
		Detach = {
			type = "method",
			args = "()",
			returns = "()",
			description = "detach from player object is attached to",
		},
		FindAncestorByName = {
			type = "method",
			args = "(name: string)",
			returns = "(coreObject)",
			valuetype = "_coreObject",
			description = "find first ancestor that matches name, nil if not found",
		},
		FindChildByName = {
			type = "method",
			args = "(name: string)",
			returns = "(coreObject)",
			valuetype = "_coreObject",
			description = "find first immediate child that matches name, nil if not found",
		},
		FindDescendantByName = {
			type = "method",
			args = "(name: string)",
			returns = "(coreObject)",
			valuetype = "_coreObject",
			description = "find first descendant that matches name, nil if not found",
		},
		FindDescendantsByName = {
			type = "method",
			args = "(name: string)",
			returns = "(table)",
			valuetype = "table",
			description = "find descendants that matches name",
		},
		FindAncestorByType = {
			type = "method",
			args = "(typename: string)",
			returns = "(coreObject)",
			valuetype = "_coreObject",
			description = "find first ancestor of given type, nil if not found",
		},
		FindChildByType = {
			type = "method",
			args = "(typename: string)",
			returns = "(coreObject)",
			valuetype = "_coreObject",
			description = "find first immediate child of given type, nil if not found",
		},
		FindDescendantByType = {
			type = "method",
			args = "(typename: string)",
			returns = "(coreObject)",
			valuetype = "_coreObject",
			description = "find first descendant of given type, nil if not found",
		},
		FindDescendantsByType = {
			type = "method",
			args = "(typename: string)",
			returns = "(table)",
			valuetype = "table",
			description = "find descendants of given type",
		},
		IsAncestorOf = {
			type = "method",
			args = "(inputObject: coreobject)",
			returns = "(boolean)",
			description = "returns true if object is ancestor of inputObject",
		},
		MoveTo = {
			type = "method",
			args = "(targetPos: vector, duration: number)",
			returns = "()",
			description = "smoothly move object to targetPos over given amount of time",
		},
		RotateTo = {
			type = "method",
			args = "(targetRotation: rotation|quaternion, duration: number)",
			returns = "()",
			description = "smoothly rotate object to targetRotation over given amount of time",
		},
		MoveContinuous = {
			type = "method",
			args = "(velocity: vector [, localSpace=false: boolean])",
			returns = "()",
			description = "Smoothly moves the object over time by the given velocity vector.",
		},
		RotateContinuous = {
			type = "method",
			args = "(angularVelocity: rotation|quaternion [, multiplier: number, localSpace=false: boolean])",
			returns = "()",
			description = "Smoothly rotates the object over time by the given angular velocity. Because the limit is 179 degrees, the second param is an optional multiplier, for very fast rotations. Third parameter specifies if this should be done in local space (true) or world space (false).",
		},
		StopMove = {
			type = "method",
			args = "()",
			returns = "()",
			description = "Interrupts further movement from move_to() or move_continuous().",
		},
		StopRotate = {
			type = "method",
			args = "()",
			returns = "()",
			description = "Interrupts further rotation from rotate_to() or rotate_continuous().",
		},
		Follow = {
			type = "method",
			args = "(target: coreObject [, speed: number, followDistance: number])",
			returns = "()",
			description = "Follows a dynamic object at a certain speed. If the speed is not supplied it will follow as fast as possible. The third parameter specifies a distance to keep away from the target.",
		},
		LookAtContinuous = {
			type = "method",
			args = "(target: coreObject [, lockPitch: boolean, trackSpeed: number])",
			returns = "()",
			description = "Smoothly rotates a CoreObject to look at another given CoreObject. Second parameter is optional and locks the pitch. Third parameter is how fast it tracks the target. If speed is not supplied it tracks as fast as possible.",
		},
		LookAtCamera = {
			type = "method",
			args = "([lockPitch: boolean])",
			returns = "()",
			description = "Continuously looks at the local camera. The bool parameter is optional and locks the pitch.",
		},
		LookAt = {
			type = "method",
			args = "(lookAtPos: vector)",
			returns = "()",
			description = "Instantly rotates the object to look at the given location.",
		},
		Destroy = {
			type = "method",
			args = "()",
			returns = "()",
			description = "Destroys the object.  You can check whether an object has been destroyed by calling is_valid(object), which will return true if object is still a valid object, or false if it has been destroyed",
		},
		GetCustomProperty = {
			type = "method",
			args = "(propertyName: string)",
			returns = "(property_value)",
			description = "Gets data which has been added to an object using the custom property system.  Returns the value, which can be an integer, float, bool, string, Vector3, Rotator, Color, a MUID string, or nil if not found.  Second return value is a bool, true if found and false if not.\n- Note: String return value is “” (an empty string), not nil, if the field is empty.",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_coreObjectReference()
return {
	type = "class",
	description = "core object",
	childs = {
		id = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		GetObject = {
			type = "method",
			args = "()",
			returns = "(_coreobject)",
			description = "get referenced object. May depend on whether object has spawned yet",
		},
		WaitForObject = {
			type = "method",
			args = "()",
			returns = "(_coreobject)",
			description = "wait until the object is spawned, then return the object",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_audioObject()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		Play = {
			type = "method",
			description = "Begins sound playback.",
			args = "()",
			returns = "()",
		},
		Stop = {
			type = "method",
			description = "Stops sound playback.",
			args = "()",
			returns = "()",
		},
		FadeIn = {
			type = "method",
			description = "Starts playing and fades the sound in over the given time.",
			args = "(time: number)",
			returns = "()",
		},
		FadeOut = {
			type = "method",
			description = "Fades the sound out and stops over time seconds.",
			args = "(time: number)",
			returns = "()",
		},

		isPlaying = {
			type = "value",
			description = "whether sound is currently playing",
			valuetype = "",
		},
		length = {
			type = "value",
			description = "sound's length in seconds",
			valuetype = "",
		},
		currentPlaybackTime = {
			type = "value",
			description = "Returns the playback position (in seconds) of the sound.",
			valuetype = "",
		},
		isSpatializationDisabled = {
			type = "value",
			description = "Default false. Set true to play sound without 3D positioning.",
			valuetype = "boolean",
		},
		isOcclusionEnabled = {
			type = "value",
			description = "whether occlutsion is enabled",
			valuetype = "boolean",
		},
		isAutoPlayEnabled = {
			type = "value",
			description = "Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded.",
			valuetype = "boolean",
		},
		isTransient = {
			type = "value",
			description = "Default false. If set to true, the sound will automatically destroy itself after it finishes playing.",
			valuetype = "boolean",
		},
		isAutoRepeatEnabled = {
			type = "value",
			description = "Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't (can be useful for looping music.)",
			valuetype = "boolean",
		},
		pitch = {
			type = "value",
			description = "Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (so 0.2-1 will work, above 1 might not.)",
			valuetype = "number",
		},
		volume = {
			type = "value",
			description = "Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up.",
			valuetype = "number",
		},
		radius = {
			type = "value",
			description = "Default 0 (off.) If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume.",
			valuetype = "number",
		},
		falloff = {
			type = "value",
			description = "Default 0 (off). If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero",
			valuetype = "number",
		},
	}
}
end

local function def_blueprintObject()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		GetSmartProperty = {
			type = "method",
			description = "Gets the current value of an exposed blueprint variable.  Returns the value, which can be an integer, float, bool, string, Vector3, Rotator, Color, or nil if not found.  Second return value is a bool, true if found and false if not.",
			args = "(propName: string)",
			returns = "(value, boolean)",
		},
		SetSmartProperty = {
			type = "method",
			description = "Sets the value of an exposed blueprint variable.  Value, which can be a number, bool, string, Vector3, Rotator, or Color, but must match the type of the parameter on the blueprint.  Returns true if set successfully and false if not.",
			args = "(propName: string)",
			returns = "(boolean)",
		},
	}
}
end

local function def_equipmentObject()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		socket = {
			type = "value",
			description = "Determines which point on the avatar’s body this equipment will be attached.",
			valuetype = "string",
		},
		owner = {
			type = "value",
			description = "Which Player the Equipment is attached to",
			valuetype = "_player",
		},

		equippedEvent = {
			type = "value",
			description = "event(equipment, player): fired when equipment is equipped on player",
			valuetype = "_eventType",
		},
		unequippedEvent = {
			type = "value",
			description = "event(equipment, player): fired when equipment is unequipped from player",
			valuetype = "_eventType",
		},

		GetAbilities = {
			type = "method",
			args = "()",
			returns = "(table)",
			valuetype = "table",
			description = "A table of Abilities that are assigned to this Equipment. Players who equip it will get these Abilities",
		},
		Equip = {
			type = "method",
			description = "Attaches the Equipment to a Player. They gain any abilities assigned to the Equipment. If the Equipment is already attached to another Player it will first unequip from that other Player before equipping unto the new one.",
			args = "(player: Player)",
			returns = "()",
		},
		Unequip = {
			type = "method",
			description = "Detaches the Equipment from any Player it may currently be attached to. The player loses any abilities granted by the Equipment",
			args = "()",
			returns = "()",
		},
		AddAbility = {
			type = "method",
			description = "Adds an Ability to the list of abilities on this Equipment",
			args = "(ability: Ability)",
			returns = "()",
		},
	}
}
end

local function def_playerStartObject()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		team = {
			type = "value",
			description = "A tag controlling which players can spawn at this start point.",
			valuetype = "string",
		},
	}
}
end

local function def_pointLightObject()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		intensity = {
			type = "value",
			description = [[The intensity of the light. This has two interpretations, depending on use_attenuation_radius:
true: the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb.
false: the light's Intensity is a brightness scale.
			]],
			valuetype = "number",
		},
		hasAttenuationRadius = {
			type = "value",
			description = "The attenuation method of the light. When enabled, attenuation_radius is used. When disabled, fall_off_exponent is used. Also changes the interpretation of the intensity property, see intensity for details.",
			valuetype = "boolean",
		},
		attenuationRadius = {
			type = "value",
			description = "Bounds the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more.",
			valuetype = "number",
		},
		fallOffExponent = {
			type = "value",
			description = "Controls the radial falloff of the light when use_attenuation_radius is disabled. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents.",
			valuetype = "number",
		},
		sourceRadius = {
			type = "value",
			description = "Radius of light source shape.",
			valuetype = "number",
		},
		sourceLength = {
			type = "value",
			description = "Length of light source shape.",
			valuetype = "number",
		},
		isShadowCaster = {
			type = "value",
			description = "Does this light cast shadows?",
			valuetype = "number",
		},
		hasTemperature = {
			type = "value",
			description = "true: use temperature value as illuminant. false: use white (D65) as illuminant.",
			valuetype = "number",
		},
		temperature = {
			type = "value",
			description = "Color temperature in Kelvin of the blackbody illuminant. White (D65) is 6500K",
			valuetype = "number",
		},
		GetColor = {
			type = "method",
			args = "()",
			returns = "(color)",
			valuetype = "_color",
			description = "return light color",
		},
		SetColor = {
			type = "method",
			args = "(color)",
			returns = "()",
			valuetype = "",
			description = "set light color",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_projectile()
return {
	type = "class",
	childs = {
		sourceAbility = {
			type = "value",
			description = "",
			valuetype = "_ability",
		},
		owner = {
			type = "value",
			description = "The player who fired this projectile. Setting this property ensures the Projectile does not impact the owner or their allies. This will also change the color of the projectile if teams are being used in the game.",
			valuetype = "_player",
		},
		speed = {
			type = "value",
			description = " Centimeters per second movement.",
			valuetype = "number",
		},
		maxSpeed = {
			type = "value",
			description = "Max cm/s. Zero means no limit.",
			valuetype = "number",
		},
		gravityScale = {
			type = "value",
			description = "How much drop. 1 means normal gravity. Zero can be used to make a Projectile go in a straight line.",
			valuetype = "number",
		},
		drag = {
			type = "value",
			description = "Deceleration. Important for homing Projectiles (try a value around 5). Negative drag will cause the Projectile to accelerate.",
			valuetype = "number",
		},
		bouncesRemaining = {
			type = "value",
			description = "Number of bounces remaining before it dies.",
			valuetype = "number",
		},
		bounciness = {
			type = "value",
			description = "Velocity % maintained after a bounce. Defaults to 0.6",
			valuetype = "number",
		},
		lifeSpan = {
			type = "value",
			description = "Max seconds the projectile will exist. Defaults to 10",
			valuetype = "number",
		},
		shouldBounceOnPlayers = {
			type = "value",
			description = "Determines if the projectile should bounce off players or be destroyed, when bounces is used.",
			valuetype = "boolean",
		},
		piercesRemaining = {
			type = "value",
			description = "Number of objects that will be pierced before it dies. A piercing Projectile loses no velocity when going through objects, but still fires the on_impact event. If combined with bounces, all pierces are spent before bounces are counted",
			valuetype = "number",
		},
		capsuleRadius = {
			type = "value",
			description = "Shape of the projectile’s collision. Default 22",
			valuetype = "number",
		},
		capsuleLength = {
			type = "value",
			description = "Shape of the projectile’s collision. A value of zero will make it shaped like a Sphere.",
			valuetype = "number",
		},
		homingTarget = {
			type = "value",
			description = "The projectile accelerates towards its target.",
			valuetype = "_player",
		},
		homingAcceleration = {
			type = "value",
			description = "Magnitude of acceleration towards the target.",
			valuetype = "number",
		},
		shouldDieOnImpact = {
			type = "value",
			description = "If true the projectile is automatically destroyed when it hits something, unless it has bounces remaining.",
			valuetype = "boolean",
		},
		impactEvent = {
			type = "value",
			description = "event(p: Projectile, other: object, hitRes: HitResult) fires when the Projectile collides with something. Impacted object parameter will be either of type CoreObject or Player, but can also be nil. The HitResult parameter contains properties such as .impact_point, .impact_normal and .transform, describing the point of contact between the Projectile and the impacted object. ",
			valuetype = "_eventType",
		},
		lifeSpanEndedEvent = {
			type = "value",
			description = "event(p: Projectile) fires when the Projectile reaches the end of its lifespan. Called before it is destroyed.",
			valuetype = "_eventType",
		},
		homingFailedEvent = {
			type = "value",
			description = "event(p: Projectile) fires when the target is no longer valid, for example the player disconnected from the game or the object was destroyed somehow",
			valuetype = "_eventType",
		},

		Destroy = {
			type = "method",
			description = "immediately destroys this object",
			args = "()",
			returns = "()",
		},
		GetTransform = {
			type = "method",
			args = "()",
			returns = "(transform)",
			valuetype = "_transform",
			description = "get local transform",
		},
		GetWorldRotation = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "get world rotation",
		},
		SetWorldRotation = {
			type = "method",
			args = "(rotation : rotation)",
			returns = "()",
			valuetype = "",
			description = "set world rotation",
		},
		GetVelocity = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "current velocity",
		},
		SetVelocity = {
			type = "method",
			args = "(velocity: vector)",
			returns = "()",
			valuetype = "",
			description = "set velocity",
		},
	}
}
end

local function def_replicator()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		GetValue = {
			type = "method",
			description = "Returns the named custom parameter and whether or not the parameter was found.",
			args = "(paramName: string)",
			returns = "(value)",
		},
		SetValue = {
			type = "method",
			description = "Sets the named custom parameter and returns whether or not it was set successfully. Reasons for failure are not being able to find the parameter or the Object parameter being the wrong type",
			args = "(paramName: string, value)",
			returns = "(boolean)",
		},
		valueChangedEvent = {
			type = "value",
			description = "event(replicator: coreObject, paramName: string) fires whenever any of the parameters managed by the replicator receive an update. The event is fired on the server and the client. Event payload is the Replicator object and the name of the parameter that just changed.",
			valuetype = "_eventType",
		},
	}
}
end

local function def_perPlayerReplicator()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		GetPlayerReplicator = {
			type = "method",
			description = "Returns the replicator for the specified player. Can be nil if the replicator hasn’t spawned on the client yet",
			args = "(player)",
			returns = "(replicator)",
			valuetype = "_replicator",
		},
	}
}
end

local function def_staticMeshObject()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		isSimulatingPhysics = {
			type = "value",
			description = "If true, physics will be enabled for the mesh",
			valuetype = "boolean",
		},
		team = {
			type = "value",
			description = "Assigns the mesh to a team. Use Team0, Team1, etc, or an empty string for no team.",
			valuetype = "string",
		},
		isTeamColorUsed = {
			type = "value",
			description = "If true, and the mesh has been assigned to a valid team, players on that team will see a blue mesh, while other players will see red. (Requires a material that supports the color parameter.)",
			valuetype = "boolean",
		},
		isTeamCollisionDisabled = {
			type = "value",
			description = "If true, and the mesh has been assigned to a valid team, players on that team will not collide with the mesh.",
			valuetype = "boolean",
		},
		isEnemyCollisionDisabled = {
			type = "value",
			description = "If true, and the mesh has been assigned to a valid team, players on other teams will not collide with the mesh",
			valuetype = "boolean",
		},
		isCameraCollisionDisabled = {
			type = "value",
			description = "If true, the mesh will not collide with camera arm, causing it to shorten",
			valuetype = "boolean",
		},
		GetColor = {
			type = "method",
			args = "()",
			returns = "(color)",
			valuetype = "_color",
			description = "",
		},
		SetColor = {
			type = "method",
			args = "(color)",
			returns = "()",
			valuetype = "",
			description = "",
		},
		ResetColor = {
			type = "method",
			description = "Turns off the color override, if there is one",
			args = "()",
			returns = "()",
		},
		GetMaterialProperty = {
			type = "method",
			description = "Gets the current value of a parameter on a material in a given slot.  Returns the value, which can be an float, bool, Vector3, Color, or nil if not found.  Second return value is a bool, true if found and false if not.",
			args = "(slot: number, propName: string)",
			returns = "(value, boolean)",
		},
		SetMaterialProperty = {
			type = "method",
			description = "Sets the value of a parameter on a material in a given slot.  Value, which can be a number, bool, Vector3, or Color, but must match the type of the parameter on the material.  Returns true if set successfully and false if not.",
			args = "(slot: number, propName: string, value)",
			returns = "(boolean)",
		},
	}
}
end

local function def_textRendererObject()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		text = {
			type = "value",
			description = "The text being displayed by this object",
			valuetype = "string",
		},
		horizontalScale = {
			type = "value",
			description = "The horizontal size of the text.",
			valuetype = "number",
		},
		verticalScale = {
			type = "value",
			description = "The vertical size of the text",
			valuetype = "number",
		},

		GetColor = {
			type = "method",
			args = "()",
			returns = "(color)",
			valuetype = "_color",
			description = "",
		},
		SetColor = {
			type = "method",
			args = "(color)",
			returns = "()",
			valuetype = "",
			description = "",
		},
	}
}
end

local function def_trigger()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		beginOverlapEvent = {
			type = "value",
			description = "event(trigger, object) fired when an object enters the trigger volume.  The first parameter is the trigger itself.  The second is the object overlapping the trigger, which may be a CoreObject, a Player, or some other type.  Call other:is_a to check the type.  Eg, other:is_a(‘Player’), other:is_a(‘StaticMesh’), etc.",
			valuetype = "_eventType",
		},
		endOverlapEvent = {
			type = "value",
			description = "event(trigger, other: object) fired when an object exits the trigger volume.",
			valuetype = "_eventType",
		},
		interactedEvent = {
			type = "value",
			description = "event(trigger, player) fired when a player uses the interaction on a trigger volume (By default “F” key). The first parameter is the trigger itself and the second parameter is a Player",
			valuetype = "_eventType",
		},
		isInteractable = {
			type = "value",
			description = "Is the trigger interactable?",
			valuetype = "boolean",
		},
		interactionLabel = {
			type = "value",
			description = "The text players will see in their HUD when they come into range of interacting with this trigger",
			valuetype = "string",
		},
	}
}
end

local function def_weapon()
return {
	type = "class",
	inherits = "_coreObject",
	childs = {
		isReticleEnabled = {
			type = "value",
			description = "If True, the reticle will appear when this Weapon is equipped.",
			valuetype = "boolean",
		},
		maxAmmo = {
			type = "value",
			description = "How much ammo the Weapon starts with and its max capacity. If set to -1 then the Weapon has infinite capacity and doesn’t need to reload.",
			valuetype = "number",
		},
		currentAmmo = {
			type = "value",
			description = "Current amount of ammo stored in this Weapon",
			valuetype = "number",
		},
		ammoType = {
			type = "value",
			description = "A unique identifier for the ammunition type",
			valuetype = "string",
		},
		isAmmoFinite = {
			type = "value",
			description = "Determines where the ammo comes from. If True, then ammo will be drawn from the Player’s Resource inventory and reload will not be possible until the Player acquires more ammo somehow. If False, then the Weapon simply reloads to full and inventory Resources are ignored",
			valuetype = "boolean",
		},
		projectileSpeed = {
			type = "value",
			description = "speed in cm/s",
			valuetype = "float",
		},
		projectileLifeSpan = {
			type = "value",
			description = "duration of projectile",
			valuetype = "float",
		},
		projectileGravity = {
			type = "value",
			description = "gravity scale applied to projectile",
			valuetype = "float",
		},
		projectileLength = {
			type = "value",
			description = "length of capsule collision",
			valuetype = "float",
		},
		projectileRadius = {
			type = "value",
			description = "radius of capsule collision",
			valuetype = "float",
		},
		projectileDrag = {
			type = "value",
			description = "TODO: add description",
			valuetype = "float",
		},
		projectileBounceCount = {
			type = "value",
			description = "number of bounces before project is destroyed",
			valuetype = "int",
		},
		projectilePierceCount = {
			type = "value",
			description = "number of objects pierced by projectile before it's destroyed. Each pierce generates an interaction event",
			valuetype = "int",
		},
		isHitscan = {
			type = "value",
			description = "if trye, will use instantaneous line traces to simulate shots",
			valuetype = "bool",
		},
		range = {
			type = "value",
			description = "max travel distance of projectile. for hitscan weapon, it's range of trace",
			valuetype = "float",
		},
		projectileTemplateId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		muzzleFlashTemplateId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		trailTemplateId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		beamTemplateId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		impactSurfaceTemplateId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		impactProjectileTemplateId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		impactPlayerTemplateId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		outOfAmmoSoundId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		reloadSoundId = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		multiShotCount = {
			type = "value",
			description = "Number of projectiles/hitscans that will fire simultaneously inside the spread area each time the Weapon attacks. Does not affect the amount of ammo consumed per attack.",
			valuetype = "int",
		},
		burstCount = {
			type = "value",
			description = "Number of automatic activations of the weapon that generally occur in quick succession.",
			valuetype = "int",
		},
		shotsPerSecond = {
			type = "value",
			description = "Used in conjunction with burst_count to determine the interval between automatic weapon activations.",
			valuetype = "float",
		},
		shouldBurstStopOnRelease = {
			type = "value",
			description = "If True, a burst sequence can be interrupted by the player by releasing the action button. If False, the burst continues firing automatically until it completes or the weapon runs out of ammo.",
			valuetype = "bool",
		},
		attackCooldownDuration = {
			type = "value",
			description = "Interval between separate burst sequences",
			valuetype = "float",
		},
		targetInteractionEvent = {
			type = "value",
			description = "event(WeaponInteraction) fired when a Weapon interacts with something. E.g. a shot hits a wall. The WeaponInteraction parameter contains information such as which object was hit, who owns the weapon, which ability was involved in the interaction, etc.",
			valuetype = "_eventType",
		},
		projectileSpawnedEvent = {
			type = "value",
			description = "event(weapon, projectile). fired when a weapon spawns a projectile",
			valuetype = "_eventType",
		},

		HasAmmo = {
			type = "method",
			description = "Informs whether the Weapon is able to attack or not",
			valuetype = "boolean",
		},
		Attack = {
			type = "method",
			description = "",
			valuetype = "",
		},
	}
}
end

local function def_weaponInteraction()
return {
	type = "class",
	childs = {
		targetObject = {
			type = "value",
			description = "player or coreobject",
			valuetype = "_coreObject",
		},
		projectile = {
			type = "value",
			description = "Reference to a Projectile, if one was produced as part of this interaction",
			valuetype = "_projectile",
		},
		sourceAbility = {
			type = "value",
			description = "Reference to the Ability which initiated the interaction.",
			valuetype = "_ability",
		},
		weapon = {
			type = "value",
			description = "Reference to the Weapon that is interacting",
			valuetype = "_weaponObjectType",
		},
		weaponOwner = {
			type = "value",
			description = "Reference to the Player who had the Weapon equipped at the time it was activated, ultimately leading to this interaction",
			valuetype = "_player",
		},
		travelDistance = {
			type = "value",
			description = "The distance in cm between where the weapon attack started until it impacted something.",
			valuetype = "float",
		},

		GetHitResult = {
			type = "method",
			args = "()",
			returns = "()",
			valuetype = "_hitresult",
			description = "Physics information about the impact between the weapon and the other object",
		},
		GetHitResults = {
			type = "method",
			args = "()",
			returns = "(table)",
			valuetype = "table",
			description = "Table with multiple HitResults that hit the same object, in the case of Weapons with multi-shot (e.g. Shotguns). If a single attack hits multiple targets you receive a separate interaction event for each object hit.",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_transform()
return {
	type = "class",
	childs = {
		IDENTITY = {
			type = "value",
			valuetyppe = "_transform",
		},
		GetPosition = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "return local position",
		},
		SetPosition = {
			type = "method",
			args = "(vector)",
			returns = "()",
			valuetype = "",
			description = "set local position",
		},
		GetRotation = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "get local rotation",
		},
		SetRotation = {
			type = "method",
			args = "(rotation)",
			returns = "()",
			valuetype = "",
			description = "set local rotation",
		},
		GetScale = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "get local scale",
		},
		SetScale = {
			type = "method",
			args = "(vector)",
			returns = "()",
			valuetype = "",
			description = "set local scale",
		},
		GetQuaternion = {
			type = "method",
			args = "()",
			returns = "(quaternion)",
			valuetype = "_quaternion",
			description = "",
		},
		SetQuaternion = {
			type = "method",
			args = "(quaternion)",
			returns = "()",
			valuetype = "",
			description = "",
		},
		GetForwardVector = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "",
		},
		GetRightVector = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "",
		},
		GetUpVector = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "",
		},
		GetInverse = {
			type = "method",
			args = "()",
			returns = "(transform)",
			valuetype = "_transform",
			description = "",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_vector()
return {
	type = "class",
	childs = {
		x = {
			type = "value",
			valuetype = "number",
		},
		y = {
			type = "value",
			valuetype = "number",
		},
		z = {
			type = "value",
			valuetype = "number",
		},
		size = {
			type = "value",
			description = "magnitude of vector",
			valuetype = "number",
		},
		sizeSquared = {
			type = "value",
			description = "squared magnitude of vector",
			valuetype = "number",
		},
		GetNormalized = {
			type = "method",
			description = "return a normalized version of current vector. Does not modify caller",
			args = "()",
			returns = "()",
		},
	}
}
end

local function def_vector_lib()
return {
	type = "lib",
	childs = {
		New = {
			type = "function",
			args = "(x: number, y: number, z: number)",
			description = "new() -> create (0, 0, 0).\nnew(v: number) -> creates (v, v, v)",
			returns = "(vector)",
			valuetype = "_vector",
		},
		ZERO = {
			type = "value",
			description = "(0, 0, 0)",
			valuetype = "_vector",
		},
		ONE = {
			type = "value",
			description = "(1, 1, 1)",
			valuetype = "_vector",
		},
		FORWARD = {
			type = "value",
			description = "(1, 0, 0)",
			valuetype = "_vector",
		},
		UP = {
			type = "value",
			description = "(0, 0, 1)",
			valuetype = "_vector",
		},
		RIGHT = {
			type = "value",
			description = "(0, 1, 0)",
			valuetype = "_vector",
		},
		Lerp = {
			type = "function",
			description = "linearly interpolates between two vectors by specified progress amount and return result vector",
			args = "(from: vector, to: vector, progress: number)",
			returns = "(vector)",
			valuetype = "_vector",
		},
	},
}
end

--------------------------------------------------------------------------------
local function def_rotation()
return {
	type = "class",
	childs = {
		x = {
			type = "value",
			description = "X component of rotation",
			valuetype = "number",
		},
		y = {
			type = "value",
			description = "Y component of rotation",
			valuetype = "number",
		},
		z = {
			type = "value",
			description = "Z component of rotation",
			valuetype = "number",
		},
	},
}
end

local function def_rotation_lib()
return {
	type = "lib",
	childs = {
		New = {
			type = "function",
			args = "()",
			description = "new() -> identity rotation (0, 0, 0)\nnew(q: quaternion) -> create rotation from quaternion",
			returns = "(rotation)",
			valuetype = "_rotation",
		},
		ZERO = {
			type = "value",
			description = "constant rotation (0, 0, 0)",
			valuetype = "_rotation",
		}
	}
}
end

--------------------------------------------------------------------------------
local function def_quaternion()
return {
	type = "class",
	childs = {
		x = {
			type = "value",
			description = "X component of quaternion",
			valuetype = "number",
		},
		y = {
			type = "value",
			description = "Y component of quaternion",
			valuetype = "number",
		},
		z = {
			type = "value",
			description = "Z component of quaternion",
			valuetype = "number",
		},
		w = {
			type = "value",
			description = "W component of quaternion",
			valuetype = "number",
		},
		GetRotation = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "get rotation representation of this quaternion",
		},
		GetForwardVector = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "",
		},
		GetRightVector = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "",
		},
		GetUpVector = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "",
		},
	}
}
end


local function def_quaternion_lib()
return {
	type = "lib",
	childs = {
		New = {
			type = "function",
			args = "(x: number, y: number, z: number, w: number)",
			description = "new(r: Rotation) -> quaternion from Rotation\nnew(axit: vector, angle: number) -> create quaternion from axis-angle",
			returns = "(rotation)",
			valuetype = "_quaternion",
		},
		IDENTITY = {
			type = "value",
			description = "constant identity quaternion",
			valuetype = "_quaternion",
		},
		Slerp = {
			type = "function",
			description = "linearly interpolates between two quaternions by specified progress amount and return result quaternion",
			args = "(from: quaternion, to: quaternion, progress: number)",
			returns = "(quaternion)",
			valuetype = "_quaternion",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_color()
return {
	type = "class",
	childs = {
		r = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		g = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		b = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		a = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		GetDesaturated = {
			type = "method",
			description = "Returns the desaturated version of the color. 0 represents no desaturation and 1 represents full desaturation.",
			args = "(desaturation: number)",
			returns = "(color)",
			valuetype = "_color",
		},
	}
}
end

local function def_color_lib()
return {
	type = "lib",
	childs = {
		New = {
			type = "function",
			args = "(r: number, g: number, b: number [, a: number])",
			description = "new(colorAsVec: vector) -> construct color with vector input",
			returns = "(color)",
			valuetype = "_color",
		},
		Lerp = {
			type = "function",
			description = "linearly interpolates between two colors in HSV space by specified progress amount and return result Color",
			args = "(from: color, to: color, progress: number)",
			returns = "(color)",
			valuetype = "_color",
		},
		Random = {
			type = "function",
			description = "create random color",
			args = "()",
			returns = "(color)",
			valuetype = "_color",
		},
		WHITE = { type = "value", valuetype = "_color", },
		GRAY = { type = "value", valuetype = "_color", },
		BLACK = { type = "value", valuetype = "_color", },
		TRANSPARENT = { type = "value", valuetype = "_color", },
		RED = { type = "value", valuetype = "_color", },
		GREEN = { type = "value", valuetype = "_color", },
		BLUE = { type = "value", valuetype = "_color", },
		CYAN = { type = "value", valuetype = "_color", },
		MAGENTA = { type = "value", valuetype = "_color", },
		YELLOW = { type = "value", valuetype = "_color", },
		ORANGE = { type = "value", valuetype = "_color", },
		PURPLE = { type = "value", valuetype = "_color", },
		BROWN = { type = "value", valuetype = "_color", },
		PINK = { type = "value", valuetype = "_color", },
		TAN = { type = "value", valuetype = "_color", },
		RUBY = { type = "value", valuetype = "_color", },
		EMERALD = { type = "value", valuetype = "_color", },
		SAPPHIRE = { type = "value", valuetype = "_color", },
		SILVER = { type = "value", valuetype = "_color", },
		SMOKE = { type = "value", valuetype = "_color", },
	}
}
end

--------------------------------------------------------------------------------
local function def_hitresult()
return {
	type = "class",
	childs = {
		GetImpactPosition = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "The world location where the impact occurred",
		},
		GetImpactNormal = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "Normal direction of the surface which was impacted.",
		},
		GetTransform = {
			type = "method",
			args = "()",
			returns = "(transform)",
			valuetype = "_transform",
			description = "",
		},
		other = {
			type = "value",
			description = "core object or player impacted",
			valuetype = "_coreObject",
		},
		isHeadshot = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		boneName = {
			type = "value",
			description = "",
			valuetype = "string",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_damage()
return {
	type = "class",
	childs = {
		amount = {
			type = "value",
			description = "damage amount",
			valuetype = "_vector",
		},
		reason = {
			type = "value",
			description = "context for damage",
			valuetype = "DamageReason",
		},
		sourceAbility = {
			type = "value",
			description = "Reference to the Ability which caused the Damage. Setting this automatically sets the source_ability_name",
			valuetype = "_ability",
		},
		sourceAbilityName = {
			type = "value",
			description = "Name of the ability which caused the Damage",
			valuetype = "string",
		},
		sourcePlayer = {
			type = "value",
			description = "Reference to the Player who caused the Damage. Setting this automatically sets the source_player_name",
			valuetype = "_player",
		},
		sourcePlayerName = {
			type = "value",
			description = "Name of the player who caused the Damage",
			valuetype = "string",
		},

		GetHitResult = {
			type = "method",
			args = "()",
			returns = "(hitResult)",
			valuetype = "_hitresult",
			description = "Forward the HitResult information if this damage was caused by a Projectile impact.",
		},
		SetHitResult = {
			type = "method",
			args = "(hitResult: hitResult)",
			returns = "()",
			valuetype = "",
			description = "",
		},
	}
}
end

local function def_damage_lib()
return {
	type = "lib",
	childs = {
		New = {
			type = "function",
			args = "(damageAmount: number)",
			returns = "(damage)",
			valuetype = "_damage",
		},
	}
}
end

local function def_damageReason()
return {
	type = "class",
	childs = {
		UNKNOWN = { type = "value", valuetype = "number", },
		COMBAT = { type = "value", valuetype = "number", },
		FRIENDLY_FIRE = { type = "value", valuetype = "number", },
		MAP = { type = "value", valuetype = "number", },
		NPC = { type = "value", valuetype = "number", },
	}
}
end

--------------------------------------------------------------------------------
local function def_player()
return {
	type = "class",
	childs = {
		name = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		id = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		team = {
			type = "value",
			description = "",
			valuetype = "string",
		},
		animationSet = {
			type = "value",
			description = "Which set of animations to use for this player. Values can be unarmed, one_handed or crossbow",
			valuetype = "string",
		},
		activePose = {
			type = "value",
			description = "Determines an animation pose to hold during idle. Default value is none. Other values can be sit_car_low, aim_rifle_shoulder, carry_object_high, score_card, carry_object_heavy, carryl_object_low",
			valuetype = "string",
		},
		facingMode = {
			type = "value",
			description = "controls mode to use for this player. Values can be strafe or loose.",
			valuetype = "string",
		},
		hitPoints = {
			type = "value",
			description = "current hitpoints",
			valuetype = "number",
		},
		maxHitPoints = {
			type = "value",
			description = "max hitpoints",
			valuetype = "number",
		},
		stepHeight = {
			type = "value",
			description = "Maximum height in centimeters the player can step up. Range is 0-100, default is 45",
			valuetype = "number",
		},
		walkSpeed = {
			type = "value",
			description = "Walk speed as a fraction of default.  Range is 0-10, default is 1",
			valuetype = "number",
		},
		swimSpeed = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		maxAcceleration = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		brakingDecelerationFalling = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		brakingDecelerationWalking = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		groundFriction = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		brakingFrictionFactor = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		walkableFloorAngle = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		cameraSensitivity = {
			type = "value",
			description = "default 1.0, multiplier",
			valuetype = "number",
		},
		maxJumpCount = {
			type = "value",
			description = "max number of jumps. if 0, jump is disabled",
			valuetype = "number",
		},
		gravityScale = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		maxSwimSpeed = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		touchForceFactor = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		isCrouchEnabled = {
			type = "value",
			description = "turns crouching on/off for a player",
			valuetype = "boolean",
		},
		mass = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		buoyancy = {
			type = "value",
			description = "1.0 is neutral buoyancy, where player won't sink or float naturally. < 1 will sink, > 1 fill float",
			valuetype = "number",
		},
		isAccelerating = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isCrouching = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isClimbing = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isFlying = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isGrounded = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isJumping = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isMounted = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isSwimming = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isWalking = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		isDead = {
			type = "value",
			description = "",
			valuetype = "boolean",
		},
		cursorMoveInputMode = {
			type = "value",
			description = "set which mouse button to use for mouse-hold move. Values are CursorMoveInput.NONE/LEFT_MOUSE/RIGHT_MOUSE/LEFT_OR_RIGHT_MOUSE",
			valuetype = "CursorMoveInput",
		},
		canTopdownCameraRotate = {
			type = "value",
			description = "if true, camera can rotate in topdown mode",
			valuetype = "boolean",
		},
		shouldRotationFollowCursor = {
			type = "value",
			description = "if true, character will rotate towards mouse cursor. If gamepad is attached, will use right thumbstick for character rotation",
			valuetype = "boolean",
		},
		scrollZoomSpeed = {
			type = "value",
			description = "multiplier to mouse wheel zoom speed",
			valuetype = "boolean",
		},
		isCursorVisible = {
			type = "value",
			description = "is mouse cursor visible",
			valuetype = "boolean",
		},
		isCursorLocked = {
			type = "value",
			description = "whether to lock cursor in viewport",
			valuetype = "boolean",
		},
		isCursorInteractableWithUI = {
			type = "value",
			description = "whether cursor can interact with clickable UI, like buttons",
			valuetype = "boolean",
		},
		spreadModifier = {
			type = "value",
			description = "",
			valuetype = "number",
		},
		currentSpread = {
			type = "value",
			description = "",
			valuetype = "number",
		},

		damagedEvent = {
			type = "value",
			description = "event(player, damage): fires when player takes damage",
			valuetype = "_eventType",
		},
		diedEvent = {
			type = "value",
			description = "event(player): fires when player dies",
			valuetype = "_eventType",
		},
		respawnedEvent = {
			type = "value",
			description = "event(player): fires when player respawns",
			valuetype = "_eventType",
		},
		bindingPressedEvent = {
			type = "value",
			description = "event(player, string): fires when action binding is pressed. second parameter is binding",
			valuetype = "_eventType",
		},
		bindingReleasedEvent = {
			type = "value",
			description = "event(player, string): fires when action binding is released",
			valuetype = "_eventType",
		},
		keyValuePairReceivedEvent = {
			type = "value",
			description = "event(player, key, value): fires when a key value pair is received from SendKeyValuePairToServer",
			valuetype = "_eventType",
		},

		GetTransform = {
			type = "method",
			args = "()",
			returns = "(transform)",
			valuetype = "_transform",
			description = "get local transform",
		},
		SetTransform = {
			type = "method",
			args = "(transform: transform)",
			returns = "()",
			valuetype = "",
			description = "set local transform",
		},
		GetPosition = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "return local position",
		},
		SetPosition = {
			type = "method",
			args = "(vector)",
			returns = "()",
			valuetype = "",
			description = "set local position",
		},
		GetRotation = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "get local rotation",
		},
		SetRotation = {
			type = "method",
			args = "(rotation)",
			returns = "()",
			valuetype = "",
			description = "set local rotation",
		},
		GetScale = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "get local scale",
		},
		SetScale = {
			type = "method",
			args = "(vector)",
			returns = "()",
			valuetype = "",
			description = "set local scale",
		},
		GetWorldTransform = {
			type = "method",
			args = "()",
			returns = "(transform)",
			valuetype = "_transform",
			description = "get world transform",
		},
		SetWorldTransform = {
			type = "method",
			args = "(transform: transform)",
			returns = "()",
			valuetype = "",
			description = "set world transform",
		},
		GetWorldPosition = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "return world position",
		},
		SetWorldPosition = {
			type = "method",
			args = "(vector : position)",
			returns = "()",
			valuetype = "",
			description = "set world position",
		},
		GetWorldRotation = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "get world rotation",
		},
		SetWorldRotation = {
			type = "method",
			args = "(rotation : rotation)",
			returns = "()",
			valuetype = "",
			description = "set world rotation",
		},
		GetWorldScale = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "get world scale",
		},
		SetWorldScale = {
			type = "method",
			args = "(vector: scale)",
			returns = "()",
			valuetype = "",
			description = "set world scale",
		},
		GetVelocity = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "current velocity",
		},
		GetRotationRate = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "",
		},
		SetRotationRate = {
			type = "method",
			args = "(rotation)",
			returns = "()",
			valuetype = "",
			description = "",
		},
		GetAbilities = {
			type = "method",
			args = "()",
			returns = "(table)",
			valuetype = "table",
			description = "",
		},
		GetEquipment = {
			type = "method",
			args = "()",
			returns = "(table)",
			valuetype = "table",
			description = "return table of equipments",
		},
		GetAttachedObjects = {
			type = "method",
			args = "()",
			returns = "(table)",
			description = "return array of attached core objects, excluding weapons",
		},
		IsA = {
			type = "method",
			description = "returns true if object type is or extends input type",
			args = "(typename: string)",
			returns = "(boolean)",
			valuetype = "boolean",
		},
		ApplyDamage = {
			type = "method",
			description = "Damages a Player. If their hitpoints go below 0 they die",
			args = "(damage: Damage)",
			returns = "()",
		},
		Die = {
			type = "method",
			description = "They will ragdoll and ignore further Damage. The optional Damage parameter is a way to communicate cause of death",
			args = "(damage: Damage)",
			returns = "()",
		},
		DisableRagdoll	= {
			type = "method",
			description = "Disables all ragdolls that have been set on the player.",
			args = "()",
			returns = "()",
		},
		SetVisibility	= {
			type = "method",
			description = "Shows or hides the player. The second parameter is optional, defaults to true, and determines if attachments to the player are hidden as well as the player",
			args = "(hidePlayer: boolean [, hideAttachments=true: boolean])",
			returns = "()",
		},
		EnableRagdoll = {
			type = "method",
			description = "Enables ragdoll for the player, starting on BoneName weighted by Weight (between 0.0 and 1.0). This can cause the player capsule to detach from the mesh. Setting CameraFollows to true will force the player capsule to stay with the mesh. All parameters are optional; BoneName defaults to the root bone, Weight defaults to 1.0, CameraFollows defaults to true. Multiple bones can have ragdoll enabled simultaneously.",
			args = "(boneName: string, weight: number, cameraFollows: boolean)",
			returns = "()",
		},
		LockCamera = {
			type = "method",
			description = "locks camera, at current direction, or input direction",
			args = "(enabled: boolean | dir: vector | rot: rotation)",
			returns = "()",
		},
		Respawn = {
			type = "method",
			description = "Resurrects a dead Player at one of the Start Points. Optional position and rotation parameters can be used to specify a location",
			args = "([optionalPos: vector, optionalRot: rotation])",
			returns = "()",
		},
		SetCameraDistance = {
			type = "method",
			description = "Sets the Distance the camera floats from the player. Using a negative Distance will reset it to default.",
			args = "(distance: number, transition: boolean)",
			returns = "()",
		},
		SetCameraOffset = {
			type = "method",
			description = "Adjusts the focus point for the camera (what the camera looks at and rotates around). Defaults to just off the shoulder. The Offset is calculated from the middle of the player.",
			args = "(offset: vector, transition: boolean)",
			returns = "()",
		},
		ResetCamera = {
			type = "method",
			description = "Sets the camera back to default, 3rd person behind character. If Transition is set to True (default behavior) the change will be smooth",
			args = "(transition=true: bool)",
			returns = "()",
		},
		SetCameraOverTheShoulder = {
			type = "method",
			description = "Sets the camera to 3rd person over the shoulder. Ideal for firing weapons. If Transition is set to True (default behavior) the change will be smooth",
			args = "(transition=true: bool)",
			returns = "()",
		},
		SetupCameraTopdownFollow = {
			type = "method",
			description = "set camera in topdown mode. For more options, please use Camera Settings object",
			args = "(pitch: number, yaw : number, initialDist: number, minDist: number, maxDist: number)",
			returns = "()",
		},
		SetupCameraFps = {
			type = "method",
			description = "set camera in fps mode, with given offset",
			args = "([cameraOffset: vector])",
			returns = "()",
		},
		SetCameraFov = {
			type = "method",
			description = "Sets the camera’s field of view for the player.",
			args = "(fov: number)",
			returns = "()",
		},
		SetCameraEnableCollision = {
			type = "method",
			description = "",
			args = "(show: bool)",
			returns = "()",
		},
		GetCameraForward = {
			type = "method",
			description = "get camera forward vector, only valid for local player",
			args = "()",
			returns = "(_vector)",
		},
		GetCameraPosition = {
			type = "method",
			description = "get camera position, only valid for local player",
			args = "()",
			returns = "(_vector)",
		},
		ForceHideModelOnOwnerClient = {
			type = "method",
			description = "hide local client's model only on its own client, intended for sniper scoping, etc",
			args = "(bool)",
			returns = "()",
		},
		SetReticleVisible = {
			type = "method",
			description = "Shows or hides the reticle for the player",
			args = "(show: bool)",
			returns = "()",
		},
		ShowHitFeedback = {
			type = "method",
			description = "Shows diagonal crosshair feedback. Useful, e.g. when a shot connects with a target. Optional Color defaults to red",
			args = "(color: color)",
			returns = "()",
		},
		AddImpulse = {
			type = "method",
			description = "Adds an impulse force to the player.",
			args = "(impulse: vector)",
			returns = "()",
		},
		ResetVelocity = {
			type = "method",
			description = "Resets the player’s velocity to zero",
			args = "()",
			returns = "()",
		},
		SetNameVisible = {
			type = "method",
			description = "set nameplace visible",
			args = "(boolean)",
			returns = "()",
		},
		PlayAnimation = {
			type = "method",
			description = "Plays a specific animation.",
			args = "(animName: string, isLooping: bool, duration: number)",
			returns = "()",
		},
		ClearResources = {
			type = "method",
			description = "Removes all resources from a player",
			args = "()",
			returns = "()",
		},
		GetResource = {
			type = "method",
			description = "Returns the amount of a resource owned by a player.",
			args = "(resourceName: string)",
			returns = "(number)",
		},
		SetResource = {
			type = "method",
			description = "Sets a specific amount of a resource on a player",
			args = "(resourceName: string, amount: number)",
			returns = "()",
		},
		AddResource = {
			type = "method",
			description = "Adds an amount of a resource to a player",
			args = "(resourceName: string, amount: number)",
			returns = "()",
		},
		RemoveResource = {
			type = "method",
			description = "Subtracts an amount of a resource from a player. Does not go below 0.",
			args = "(resourceName: string, amount: number)",
			returns = "()",
		},
		TransferToGame = {
			type = "method",
			description = "Play mode only. Transfers player to the game specified by the passed-in game ID.",
			args = "(gameId: string)",
			returns = "()",
		},
		SendKeyValuePairToServer = {
			type = "method",
			description = "send a key value pair to server. Key is string, value can be string, number or vector",
			args = "(key: string, value)",
			returns = "()",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_cursorMoveInput_lib()
return {
	type = "lib",
	childs = {
		None = { type = "value" },
		LMB = { type = "value" },
		RMB = { type = "value" },
		EitherMB = { type = "value" },
	}
}
end

--------------------------------------------------------------------------------
local function def_game()
	return {
		type = "class",
		description = "game lib",
		childs = {
			root = {
				type = "value",
				description = "",
				valuetype = "_coreObject",
			},
			playerJoinedEvent = {
				type = "value",
				description = "event(player) fires when a player has joined game and ready",
				valuetype = "_eventType",
			},
			playerLeftEvent = {
				type = "value",
				description = "event(player) fires when a player has disconnected from the game or their character has been destroyed",
				valuetype = "_eventType",
			},
			abilitySpawnedEvent = {
				type = "value",
				description = "event(Ability) fires when ability is spawned. Useful for client contexts to hook up to ability events",
				valuetype = "_eventType",
			},

			FindObjectsByName = {
				type = "method",
				description = "Returns a table containing all the objects in the hierarchy with a matching name.  If none match, an empty table is returned",
				args = "(name: string)",
				returns = "(table)",
			},
			FindObjectsByType = {
				type = "method",
				description = "Returns a table containing all the objects in the hierarchy whose type is or extends the specified type.  If none match, an empty table is returned.  See below for valid type names.",
				args = "(typename: string)",
				returns = "(table)",
				valuetype = "",
			},
			FindObjectByName = {
				type = "method",
				description = "Returns the first object found with a matching name. In none match, nil is returned",
				args = "(name: string)",
				returns = "(coreobject)",
				valuetype = "_coreObject",
			},
			FindObjectById = {
				type = "method",
				description = "Returns the object with a given MUID.  Returns nil if no object has this ID. ",
				args = "(muid: string)",
				returns = "(coreobject)",
				valuetype = "_coreObject",
			},
			GetPlayers = {
				type = "method",
				description = "Returns a table containing the players currently in the game.",
				args = "()",
				returns = "(table)",
			},
			GetLocalPlayer = {
				type = "method",
				description = "Returns the local player (or nil on the server).",
				args = "()",
				returns = "(player)",
				valuetype = "_player",
			},
			GetAlivePlayers = {
				type = "method",
				description = "return table containing players that are alive",
				args = "()",
				returns = "(table)",
				valuetype = "_table",
			},
			FindNearestPlayer = {
				type = "method",
				description = "Returns the Player that is nearest to the given position.",
				args = "(wrtPos: vector)",
				returns = "(player)",
				valuetype = "_player",
			},
			FindNearestAlly = {
				type = "method",
				description = "Returns the Player that is nearest to the given position but is on the given team. The last parameter is optional, allowing one Player to be ignored from the search.",
				args = "(wrtPos: vector, team: string, player: toIgnore)",
				returns = "(player)",
				valuetype = "_player",
			},
			FindNearestEnemy = {
				type = "method",
				description = "Returns the Player that is nearest to the given position but is not on the given team",
				args = "(wrtPos: vector, team: string)",
				returns = "(player)",
				valuetype = "_player",
			},
			FindPlayersInCylinder = {
				type = "method",
				description = "Returns a table with all Players that are in the given area. Position’s Z is ignored with the cylindrical area always upright.",
				args = "(wrtPos: vector, radius: number)",
				returns = "(table)",
			},
			FindAlliesInCylinder = {
				type = "method",
				description = "Returns a table with all Players that are in the given cylindrical area and who belong to the given team",
				args = "(wrtPos: vector, radius: number, team: string)",
				returns = "(table)",
			},
			FindEnemiesInCylinder = {
				type = "method",
				description = "Returns a table with all Players that are in the given cylindrical area and who do not belong to the given team.",
				args = "(wrtPos: vector, radius: number, team: string)",
				returns = "(table)",
			},

			FindPlayersInSphere = {
				type = "method",
				description = "Returns a table with all Players that are in the given spherical area",
				args = "(wrtPos: vector, radius: number)",
				returns = "(table)",
			},
			FindAlliesInSphere = {
				type = "method",
				description = "",
				args = "(wrtPos: vector, radius: number, team: string)",
				returns = "(table)",
			},
			FindEnemiesInSphere = {
				type = "method",
				description = "",
				args = "(wrtPos: vector, radius: number, team: string)",
				returns = "(table)",
			},
			AreTeamsEnemies = {
				type = "method",
				description = "",
				args = "(teamA: number, teamB: number)",
				returns = "(boolean)",
			},
			AreTeamsFriendly = {
				type = "method",
				description = "",
				args = "(teamA: number, teamB: number)",
				returns = "(boolean)",
			},

			SpawnTemplate = {
				type = "method",
				description = "Spawns an instance of a template. Location is in parent's space if parent is used, in world space otherwise",
				args = "(templateid: string, location: vector|transform [, parent: coreobject])",
				returns = "(coreobject)",
				valuetype = "_coreObject",
			},
			SpawnAsset = {
				type = "method",
				description = "Spawns an instance of a catalog asset. Asset needs to be referenced by asset reference parameter.",
				args = "(templateid: string, location: vector|transform [, parent: coreobject])",
				returns = "(coreobject)",
				valuetype = "_coreObject",
			},
			SpawnProjectile = {
				type = "method",
				description = "Spawns a Projectile with a child that is an instance of a template.",
				args = "(childTemplateId: string, startPos: vector, direction: vector)",
				returns = "(projectile)",
				valuetype = "_projectile",
			},
			SpawnAbility = {
				type = "method",
				description = "Spawns an ability object",
				args = "()",
				returns = "(ability)",
				valuetype = "_ability",
			},
			Raycast = {
				type = "method",
				description = "Traces a ray from rayStart to rayEnd, returning a HitResult with data about the impact point and object. Can be set to ignore a specific player or an entire team.",
				args = "(start: vector, end: vector [, playerToIgnore: player, teamToIgnore: string])",
				returns = "(hitresule)",
				valuetype = "_hitresult",
			},
			RaycastIgnoreAllPlayers = {
				type = "method",
				description = "same as raycast(), but ignores all players",
				args = "(start: vector, end: vector [, playerToIgnore: player, teamToIgnore: string])",
				returns = "(hitresult)",
				valuetype = "_hitresult",
			},
			GetCursorHit = {
				type = "method",
				description = "return hit result from local client’s view in direction of deprojected cursor position. Meant for client-side use only, for ability cast, please use ability.target_data.hit_location, which would contain cursor hit position at time of cast, when in topdown camera mode",
				args = "(start: vector, end: vector)",
				returns = "(hitresult)",
				valuetype = "_hitresult",
			},
			GetCursorPlaneIntersection = {
				type = "method",
				description = "get position of view to cursor direction with given plane",
				args = "(pointOnPlane: vector, optionalPlaneNormal: vector)",
				returns = "(vector, bool)",
				valuetype = "_vector",
			},
			DebugCopyToClipboard = {
				type = "method",
				args = "(toCopy: string)",
				returns = "()",
				valuetype = "",
				description = "copy given string to clipboard",
			},
			DebugDrawLine = {
				type = "method",
				args = "(startPos: vector, endPos: vector, optionalParams: table)",
				returns = "()",
				valuetype = "",
				description = "draw debug line, optional params: color (color), thickness (number), duration (number)",
			},
			DebugDrawSphere = {
				type = "method",
				args = "(center: vector, radius: number, optionalParams: table)",
				returns = "()",
				valuetype = "",
				description = "draw debug sphere, optional params: color (color), thickness (number), duration (number)",
			},
			DebugDrawBox = {
				type = "method",
				args = "(center: vector, dimensions: vector, optionalParams: table)",
				returns = "()",
				valuetype = "",
				description = "draw debug box, optional params: color (color), thickness (number), duration (number), rotation (rotation)",
			},
		}
	}
end

--------------------------------------------------------------------------------
local function def_ui()
return {
	type = "class",
	childs = {
		ShowFlyUpText = {
			type = "function",
			description = "Shows a quick text on screen that tracks its position relative to a world position. The last parameter is an optional duration",
			args = "(player: player, message: string, c: color, pos: vector [, duration : number])",
			returns = "()",
		},
		ShowBigFlyUpText = {
			type = "function",
			description = "",
			args = "(player: player, message: string, c: color, pos: vector [, duration : number])",
			returns = "()",
		},
		ShowDamageDirection = {
			type = "function",
			description = "Target player sees an arrow pointing towards some damage source. Lasts for 5 seconds.",
			args = "(target: player, source: vector|coreobject|player)",
			returns = "()",
		},
		GetScreenPosition = {
			type = "function",
			description = "Calculates the location that world_position appears on the screen. Returns a Vector3 with the x, y coordinates. Only gives results from a client context.",
			args = "(player: player, worldPos: vector)",
			returns = "(vector)",
			valuetype = "_vector",
		},
		GetScreenSize = {
			type = "function",
			description = "Returns a Vector3 with the size of the player’s screen in the x, y coordinates. Only gives results from a client context.",
			args = "(player: player)",
			returns = "()",
			valuetype = "_vector",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_baseUIControl()
return {
	type = "class",
	childs = {
		x = {
			type = "value",
			description = "",
		},
		y = {
			type = "value",
			description = "",
		},
		width = {
			type = "value",
			description = "",
		},
		height = {
			type = "value",
			description = "",
		},
		rotationAngle = {
			type = "value",
			description = "",
		},
	}
}
end

local function def_textUIControl()
return {
	type = "class",
	inherits = "_baseControl",
	childs = {
		text = {
			type = "value",
		},
		color = {
			type = "value",
			valuetype = "_color",
		},
		size = {
			type = "value",
			description = "font size",
		},
	}
}
end

local function def_statBarControl()
return {
	type = "class",
	inherits = "_baseControl",
	childs = {
		color = {
			type = "value",
			valuetype = "_color",
		},
		percent = {
			type = "value",
			description = "fill amount, 0 to 1",
		},
	}
}
end

local function def_abilityControl()
return {
	type = "class",
	inherits = "_baseControl",
	childs = {
		ability = {
			type = "value",
			valuetype = "_ability",
		},
	}
}
end

local function def_buttonControl()
return {
	type = "class",
	inherits = "_baseControl",
	childs = {
		clickedEvent = {
			type = "value",
			description = "event(button) fired when button is clicked",
			valuetype = "_eventType",
		},
		hoveredEvent = {
			type = "value",
			description = "event(button) fired when button is hovered",
			valuetype = "_eventType",
		},
		unhoveredEvent = {
			type = "value",
			description = "event(button) fired when button is unhovered",
			valuetype = "_eventType",
		},
		GetButtonColor = {
			type = "method",
			args = "()",
			returns = "(color)",
			valuetype = "_color",
			description = "get button color",
		},
		SetButtonColor = {
			type = "method",
			args = "(color)",
			returns = "()",
			valuetype = "",
			description = "set button color",
		},
		GetFontSize = {
			type = "method",
			args = "()",
			returns = "(number)",
			valuetype = "number",
			description = "get font size",
		},
		SetFontSize = {
			type = "method",
			args = "(number)",
			returns = "()",
			valuetype = "",
			description = "set font size",
		},
		GetFontColor = {
			type = "method",
			args = "()",
			returns = "(color)",
			valuetype = "_color",
			description = "get font color",
		},
		SetFontColor = {
			type = "method",
			args = "(color)",
			returns = "()",
			valuetype = "",
			description = "set font color",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_abilityPhase()
return {
	type = "class",
	childs = {
		duration = {
			type = "value",
			description = "Length in seconds of the phase. After this time the Ability moves to the next phase. Can be zero. default values per phase: 0.15, 0, 0.5 and 3",
			valuetype = "number",
		},
		canMove = {
			type = "value",
			description = "Is the Player allowed to move during this phase.",
			valuetype = "boolean",
		},
		canJump = {
			type = "value",
			description = "Is the Player allowed to jump during this phase. default False in Cast & Execute, default True in Recovery & Cooldown",
			valuetype = "boolean",
		},
		canRotate  = {
			type = "value",
			description = "Is the Player allowed to rotate during this phase",
			valuetype = "boolean",
		},
		isFlying = {
			type = "value",
			description = "When True gravity is turned off during this phase and if there is root motion it is allowed to pick up the Player off the ground.  This is primarily intended for use with the “roll” animation, or any other animation with vertical root motion.  (More detail in the Animation section)",
			valuetype = "boolean",
		},
		preventsOtherAbilities = {
			type = "value",
			description = "When True this phase prevents the player from casting another Ability, unless that other Ability has can_be_prevented set to False",
			valuetype = "boolean",
		},
		isTargetDataUpdated = {
			type = "value",
			description = "If true, there will be updated target information at the start of the phase. Otherwise, target information may be out of date",
			valuetype = "boolean",
		},
		playerFacing = {
			type = "value",
			description = [[How and if this ability rotates the player during execution. Cast and Execute default to Aim, other phases default to None. Options are:
							AbilitySetFacing.None
							AbilitySetFacing.Movement
							AbilitySetFacing.Aim
							]],
			valuetype = "AbilitySetFacing",
		},
	}
}
end

local function def_abilityPhase_lib()
return {
	type = "lib",
	childs = {
		READY = { type = "value" },
		CAST = { type = "value" },
		EXECUTE = { type = "value" },
		RECOVERY = { type = "value" },
		COOLDOWN = { type = "value" },
	}
}
end

local function def_abilitySetFacing()
return {
	type = "lib",
	childs = {
		NONE = { type = "value" },
		MOVEMENT = { type = "value" },
		AIM = { type = "value" },
	}
}
end

local function def_ability()
return {
	type = "class",
	childs = {
		enabled = {
			type = "value",
			description = "Turns an ability on/off. It stays on the player but is interrupted if enabled is set to False during an active Ability.",
			valuetype = "",
		},
		canActivateWhileDead = {
			type = "value",
			description = "Indicates if the Ability can be used while the owning Player is dead. False by default.",
			valuetype = "boolean",
		},
		name = {
			type = "value",
			description = "name of ability",
			valuetype = "string",
		},
		binding = {
			type = "value",
			description = "Which action binding will cause the Ability to activate. Possible values: ability_primary, ability_secondary, ability_feet, ability_1, ability_2, ability_ult and numeric keys from ability_extra_1 to ability_extra_0",
			valuetype = "string",
		},
		owner = {
			type = "value",
			description = "Assigning an owner applies the Ability to that Player.",
			valuetype = "_player",
		},
		castPhaseSettings = {
			type = "value",
			description = "Config data",
			valuetype = "_abilityPhase",
		},
		executePhaseSettings = {
			type = "value",
			description = "",
			valuetype = "_abilityPhase",
		},
		recoveryPhaseSettings = {
			type = "value",
			description = "",
			valuetype = "_abilityPhase",
		},
		cooldownPhaseSettings = {
			type = "value",
			description = "",
			valuetype = "_abilityPhase",
		},
		animation = {
			type = "value",
			description = "Name of the animation the Player will play when the ability is activated",
			valuetype = "string",
		},
		canBePrevented = {
			type = "value",
			description = "Used in conjunction with the phase property prevents_other_abilities so multiple abilities on the same Player can block each other during specific phases",
			valuetype = "boolean",
		},

		readyEvent = {
			type = "value",
			description = "event(Ability) fires when ability becomes ready. In this phase it is possible to activate it again",
			valuetype = "_eventType",
		},
		castEvent = {
			type = "value",
			description = "event(Ability) fires when the Ability enters the Cast phase",
			valuetype = "_eventType",
		},
		executeEvent = {
			type = "value",
			description = "event(Ability) fires when the Ability enters the Execute phase",
			valuetype = "_eventType",
		},
		recoveryEvent = {
			type = "value",
			description = "event(Ability) fires when the Ability enters the Recovery phase",
			valuetype = "_eventType",
		},
		cooldownEvent = {
			type = "value",
			description = "event(Ability) fires when the Ability enters the Cooldown phase",
			valuetype = "_eventType",
		},
		interruptedEvent = {
			type = "value",
			description = "event(Ability) fires when the Ability is interrupted.",
			valuetype = "_eventType",
		},
		tickEvent = {
			type = "value",
			description = "event(Ability) fires every tick while the Ability is active",
			valuetype = "_eventType",
		},

		Activate = {
			type = "method",
			description = "Client-context only. Activates an ability as if the button had been pressed",
			args = "()",
			returns = "()",
		},
		Interrupt = {
			type = "method",
			description = "Changes an Ability from Cast phase to Ready phase. If the Ability is in either Execute or Recovery phases it instead goes to Cooldown phase.",
			args = "()",
			returns = "()",
		},
		GetCurrentPhase = {
			type = "method",
			args = "()",
			returns = "(AbilityPhase)",
			valuetype = "AbilityPhase",
			description = "The current ability phase for this ability. value is AbilityPhase enum",
		},

		GetPhaseTimeRemaining = {
			type = "method",
			args = "()",
			returns = "(number)",
			valuetype = "number",
			description = "time left in current phase, in seconds",
		},
		GetTargetData = {
			type = "method",
			args = "()",
			returns = "(abilityTarget)",
			valuetype = "_abilityTarget",
			description = "Information about what the player has targeted this phase",
		},
		SetTargetData = {
			type = "method",
			args = "(abilityTarget)",
			returns = "()",
			valuetype = "",
			description = "",
		},
	}
}
end

local function def_abilityTarget()
return {
	type = "class",
	childs = {
		hitObject = {
			type = "value",
			description = "Object under the reticle, or center of the screen if no reticle is displayed. Can be a Player, Static Mesh, etc",
			valuetype = "object",
		},
		hitPlayer = {
			type = "value",
			description = "Convenience property that is the same as hit_object, but only if hit_object is a Player",
			valuetype = "_player",
		},
		spreadHalfAngle = {
			type = "value",
			description = "Half-angle of cone of possible target space.",
			valuetype = "float",
		},
		spreadRandomSeed = {
			type = "value",
			description = "Seed that can be used with RandomStream  for deterministic RNG.",
			valuetype = "int",
		},
		GetOwnerMovementRotation = {
			type = "method",
			args = "()",
			returns = "(rotation)",
			valuetype = "_rotation",
			description = "The direction the player is moving",
		},
		SetOwnerMovementRotation = {
			type = "method",
			args = "(rotation: rotation)",
			returns = "()",
			valuetype = "",
			description = "The direction the player is moving",
		},
		GetCameraPosition = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "The world space location of the camera",
		},
		SetCameraPosition = {
			type = "method",
			args = "(position: vector)",
			returns = "()",
			valuetype = "",
			description = "The world space location of the camera",
		},
		GetCameraForwardVector = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "The direction the camera is facing.",
		},
		SetCameraForwardVector = {
			type = "method",
			args = "(forwardDir: vector)",
			returns = "()",
			valuetype = "",
			description = "The direction the camera is facing.",
		},
		GetHitResult = {
			type = "method",
			args = "()",
			returns = "(hitResult)",
			valuetype = "_hitresult",
			description = "Physics information about the point being targeted",
		},
		SetHitResult = {
			type = "method",
			args = "(hitResult)",
			returns = "()",
			valuetype = "",
			description = "Physics information about the point being targeted",
		},
		GetHitPosition = {
			type = "method",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector",
			description = "The world space location of the object under the player’s reticle. If there is no object, a location under the reticle in the distance. If the player doesn’t have a reticle displayed, uses the center of the screen as if there was a reticle there.",
		},
		SetHitPosition = {
			type = "method",
			args = "(position: vector)",
			returns = "()",
			valuetype = "",
			description = "",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_storage()
return {
	type = "class",
	childs = {
		SaveTable = {
			type = "function",
			description = "Sets the passed in table as the current table for the given table name. Any previous values are removed",
			args = "(tableName: string, table)",
			returns = "(success: bool, errmsg: string)",
		},
		LoadTable = {
			type = "function",
			description = "Loads the table by name. If the table exists, success is true, and the second return value is the table. If the load fails or the table doesn’t exist, success is false and the second return value is a string with the error message.",
			args = "(tableName: string)",
			returns = "(success: bool, table|string)",
		},
		DeleteTable = {
			type = "function",
			description = "Deletes the table. If success is true, the table was deleted. If success is false, the second return value is an error message with the reason why (ie table doesn’t exist).",
			args = "(tableName: string)",
			returns = "(success: bool, errmsg: string)",
		},
		IncrementTable = {
			type = "function",
			description = "Adds only the key value pairs in the given table to an existing table. If the table doesn’t exist, a new one is created. If success is true, the second return value is a lua table containing only the new values as a result of the increment. Negative values can be used to decrement. If success is false, the second return value is an error message string explaining why.",
			args = "(tableName: string, table)",
			returns = "(success: bool, table|string)",
		},

		SavePlayerTable = {
			type = "function",
			description = "Sets the passed in table as the current table for the given player and table name. Any previous values are removed",
			args = "(player, tableName: string, table)",
			returns = "(success: bool, errmsg: string)",
		},
		LoadPlayerTable = {
			type = "function",
			description = "Loads the table by player and name. If the table exists, success is true, and the second return value is the table. If the load fails or the table doesn’t exist, success is false and the second return value is a string with the error message.",
			args = "(player, tableName: string)",
			returns = "(success: bool, table|string)",
		},
		DeletePlayerTable = {
			type = "function",
			description = "Deletes the table for the given player. If success is true, the table was deleted. If success is false, the second return value is an error message with the reason why (ie table doesn’t exist).",
			args = "(player, tableName: string)",
			returns = "(success: bool, errmsg: string)",
		},
		IncrementPlayerTable = {
			type = "function",
			description = "Adds only the key value pairs in the given table to an existing table. If the table doesn’t exist, a new one is created. If the key doesn’t exist, it is added. Negative values can be used to decrement. If success is true, the second return value is a lua table containing only the new values as a result of the increment. If success is false, the second return value is an error message string explaining why.",
			args = "(player, tableName: string, table)",
			returns = "(success: bool, table|string)",
		},
		IncrementPlayerTableAsync = {
			type = "function",
			description = "Same as above except execution of the script is not halted. The fourth function parameter is a function with the same inputs as returned by the above function. This function is used as a test alternative to see in what use cases async may be preferable or not",
			args = "(player, tableName: string, table, callback(bool, table|string))",
			returns = "()",
		},
	}
}
end

--------------------------------------------------------------------------------
local function def_randomStream()
return {
	type = "class",
	childs = {
		seed = {
			type = "value",
			description = "current seed used for RNG",
			valuetype = "number",
		},
		Reset = {
			type = "method",
			description = "",
			args = "()",
			returns = "()",
		},
		Mutate = {
			type = "method",
			description = "",
			args = "()",
			returns = "()",
		},
		GetNumber = {
			type = "method",
			description = "if passed in min and max values, return random number min <= result <= max. If no argument, return number between 0 and 1",
			args = "(optionalMin:number, optionalMax: number)",
			returns = "(number)",
			valuetype = "number",
		},
		GetInteger = {
			type = "method",
			description = "",
			args = "()",
			returns = "(number)",
			valuetype = "number",
		},
		GetVector3 = {
			type = "method",
			description = "",
			args = "()",
			returns = "(vector)",
			valuetype = "_vector"
		},
		GetVector3FromCone = {
			type = "method",
			description = "",
			args = "(dir: vector, coneHalfAngle: number)",
			returns = "(vector)",
			valuetype = "_vector",
		},
		GetInitialSeed = {
			type = "method",
			description = "seed used for initialize this stream",
			args = "()",
			returns = "(number)",
			valuetype = "number"
		},
	},
}
end

local function def_randomStream_lib()
return {
	type = "lib",
	childs = {
		New = {
			type = "function",
			args = "([initialSeed: number])",
			description = "",
			returns = "(randomstream)",
			valuetype = "_randomstream",
		},
	}
}
end

--------------------------------------------------------------------------------
local function create_api_main()
return {
	-- objects
	_coreObject = def_coreObject(),
	_coreObjectReference = def_coreObjectReference(),

	_script = {
		type = "class",
		description = "script object",
		inherits = "_coreObject",
		childs = {
			context = {
				type = "value",
			}
		}
	},

	_audio = def_audioObject(),
	_blueprint = def_blueprintObject(),
	_equipment = def_equipmentObject(),
	_playerStart = def_playerStartObject(),
	_pointLight = def_pointLightObject(),

	_projectile = def_projectile(),

	_replicator = def_replicator(),
	_perPlayerReplicator = def_perPlayerReplicator(),

	_staticMesh = def_staticMeshObject(),
	_textRenderer = def_textRendererObject(),
	_trigger = def_trigger(),
	_weapon = def_weapon(),
	_weaponInteraction = def_weaponInteraction(),

	_player = def_player(),
	CursorMoveInput = def_cursorMoveInput_lib();

	-- transform
	_transform = def_transform(),
	Transform = {
		type = "lib",
		childs = {
			new = {
				type = "function",
				args = "(rotation: quaternion or rotator, position: vector, scale: vector)",
				description = "new() -> creates identity transform.\nnew(xaxis: vector, yaxis: vector, zaxis: vector, translation: vector) -> create from matrix",
				returns = "(transform)",
				valuetype = "_transform",
			},
		},
	},

	_vector = def_vector(),
	Vector3 = def_vector_lib(),

	_rotation = def_rotation(),
	Rotation = def_rotation_lib(),

	_quaternion = def_quaternion(),
	Quaternion = def_quaternion_lib(),

	_color = def_color(),
	Color = def_color_lib(),

	_hitResult = def_hitresult(),

	_damage = def_damage(),
	Damage = def_damage_lib(),
	DamageReason = def_damageReason(),

	-- ability
	_ability = def_ability(),

	_abilityPhase = def_abilityPhase(),
	AbilityPhase = def_abilityPhase_lib(),
	AbilitySetFacing = def_abilitySetFacing(),
	_abilityTarget = def_abilityTarget(),

	-- event
	_eventType = {
		type = "class",
		childs = {
			Connect = {
				type = "method",
				args = "(listener: function)",
				returns = "(eventListener)",
				description = "registers given function to the event, will be called whenever the event is fired. Returns EventListener which can be used to disconnect it from event",
				valuetype = "_eventListener",
			},
		},
	},

	_eventListener = {
		type = "class",
		childs = {
			isConnected = {
				type = "value",
				description = "returns true if listener is still connected, false if owner was destroyed or event listener has been disconnected",
				valuetype = "boolean",
			},
			Disconnect = {
				type = "method",
				args = "()",
				returns = "()",
				description = "disconnect event",
			}
		},
	},

	-- ui
	UI = def_ui(),
	_baseControl = def_baseUIControl(),
	_textControl = def_textUIControl(),
	_statBarControl = def_statBarControl(),
	_abilityControl = def_abilityControl(),
	_buttonControl = def_buttonControl(),

	Storage = def_storage(),

	_randomstream = def_randomStream();
	RandomStream = def_randomStream_lib();

	-- special values
	script = {
		type = "value",
		description = "script object",
		valuetype = "_script"
	},

	game = def_game(),

	-- functions
	time = {
		type = "function",
		description = "return time in seconds since world has been brought up for play",
		args = "()",
		returns = "(timeInSeconds: number)",
	},
	print = {
		type = "function",
		description = "Print a message to the event log. Press ` to view messages",
		args = "(message: string)",
		returns = "()",
	},
	warn = {
		type = "function",
		description = "Similar to print(), but includes the script name and line number",
		args = "(message: string)",
		returns = "()",
	},
	wait = {
		type = "function",
		description = "Pauses execution of the current script for some number of seconds.  If no number is given, or the number is very small, resumes execution on the next tick",
		args = "(duration: number)",
		returns = "()",
	},

	print_to_screen = {
		type = "function",
		description = "print message to screen",
		args = "(message: string)",
		returns = "()",
	},
	print_to_screen_color = {
		type = "function",
		description = "print message to screen with given color",
		args = "(message: string, color: color)",
		returns = "()",
	},

	--[[ defining here will conflict with base math table
	math = {
		type = "lib",
		childs = {
			clamp = {
				type = "function",
				description = "Clamps value between lower and upper, inclusive. If lower and upper are not specified, defaults to 0 and 1.",
				args = "(val: number, lower: number, upper: number)",
				returns = "(number)",
			},
			lerp = {
				type = "function",
				description = "Linear interpolation between from and to.  t should be a floating point number from 0 to 1, with 0 returning from and 1 returning to.",
				args = "(from: number, to: number, t: number)",
				returns = "(number)",
			},
			round = {
				type = "function",
				description = "Rounds value to an integer, or to an optional number of decimal places, and returns the rounded value",
				args = "(val: number, numDecimals: number)",
				returns = "(number)",
			},
		},
	},
	]]

	is_valid = {
		type = "function",
		description = "Returns true if object is still a valid object, or false if it has been destroyed",
		args = "(coreobject)",
		returns = "(boolean)",
	},
}
end -- end create_api_main()

--------------------------------------------------------------------------------

return create_api_main()
