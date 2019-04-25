# Best Practices

## _G vs require

require() explicitly makes a script execute if it hasn't already, and only executes a given script once.

If you need multiple instances of the same script dynamically spawned require
doesn't make sense


## Using External Data

Regarding external data, you can use require() and a script that returns a long string to encapsulate json data in its own script.  Then use require again with a json library from the internet like this one:  https://raw.githubusercontent.com/rxi/json.lua/master/json.lua

To make a script that returns a json string when you require it, start with
this:

```lua
return [===[

]===]
```

and just paste your json into the empty line in the middle.  No need to escape quotes or anything, as long as your json doesn't contain the string "]===]"