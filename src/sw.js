var VERSION = "v1"

var cacheFirstFiles = [
    "assets/api/luacheckrc.zip",
    "assets/api/manticoreapi.lua",
    "assets/fonts/brands.min.css",
    "assets/fonts/fontawesome.min.css",
    "assets/fonts/regular.min.css",
    "assets/fonts/solid.min.css",
    "assets/fonts/material-icons.css",
    "assets/javascripts/lightgallery.min.js",
    "assets/placeholder_480p.png",
    "assets/placeholder_720p.png",
    "assets/icons/apple-icon-180.png",
    "assets/icons/CoreIcon_192x192.png",
    "assets/icons/CoreIcon_512x512.png"
]

var networkFirstFiles = ["./", "404.html", "offline.html"]

var cacheFiles = cacheFirstFiles.concat(networkFirstFiles)

self.addEventListener("install", event => {
    event.waitUntil(
        caches.open(VERSION).then(cache => {
            return cache.addAll(cacheFiles)
        })
    )
})

self.addEventListener("fetch", event => {
    if (event.request.method !== "GET") {
        return
    }
    if (networkFirstFiles.indexOf(event.request.url) !== -1) {
        event.respondWith(networkElseCache(event))
    } else if (cacheFirstFiles.indexOf(event.request.url) !== -1) {
        event.respondWith(cacheElseNetwork(event))
    } else {
        event.respondWith(fetch(event.request))
    }
})

// If cache else network.
// For images and assets that are not critical to be fully up-to-date.
// developers.google.com/web/fundamentals/instant-and-offline/offline-cookbook/
// #cache-falling-back-to-network
function cacheElseNetwork(event) {
    return caches.match(event.request).then(response => {
        function fetchAndCache() {
            return fetch(event.request).then(response => {
                // Update cache.
                caches
                    .open(VERSION)
                    .then(cache => cache.put(event.request, response.clone()))
                return response
            })
        }

        // If not exist in cache, fetch.
        if (!response) {
            return fetchAndCache()
        }

        // If exists in cache, return from cache while updating cache in background.
        fetchAndCache()
        return response
    })
}

// If network else cache.
// For assets we prefer to be up-to-date (i.e., JavaScript file).
function networkElseCache(event) {
    return caches.match(event.request).then(match => {
        if (!match) {
            return fetch(event.request)
        }
        return (
            fetch(event.request).then(response => {
                // Update cache.
                caches
                    .open(VERSION)
                    .then(cache => cache.put(event.request, response.clone()))
                return response
            }) || response
        )
    })
}
