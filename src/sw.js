var VERSION = "v3"

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
    "assets/icons/apple-icon-120.png",
    "assets/icons/apple-icon-152.png",
    "assets/icons/apple-icon-167.png",
    "assets/icons/apple-splash-1125-2436.png",
    "assets/icons/apple-splash-1136-640.png",
    "assets/icons/apple-splash-1242-2208.png",
    "assets/icons/apple-splash-1242-2688.png",
    "assets/icons/apple-splash-1334-750.png",
    "assets/icons/apple-splash-1536-2048.png",
    "assets/icons/apple-splash-1668-2224.png",
    "assets/icons/apple-splash-1668-2388.png",
    "assets/icons/apple-splash-1792-828.png",
    "assets/icons/apple-splash-2048-1536.png",
    "assets/icons/apple-splash-2048-2732.png",
    "assets/icons/apple-splash-2208-1242.png",
    "assets/icons/apple-splash-2224-1668.png",
    "assets/icons/apple-splash-2388-1668.png",
    "assets/icons/apple-splash-2436-1125.png",
    "assets/icons/apple-splash-2688-1242.png",
    "assets/icons/apple-splash-2732-2048.png",
    "assets/icons/apple-splash-640-1136.png",
    "assets/icons/apple-splash-750-1334.png",
    "assets/icons/apple-splash-828-1792.png",
    "assets/icons/apple-touch-icon.png",
    "assets/icons/browserconfig.xml",
    "assets/icons/CoreIcon_192x192.png",
    "assets/icons/CoreIcon_512x512.png",
    "assets/icons/favicon-16x16.png",
    "assets/icons/favicon-196.png",
    "assets/icons/favicon-32x32.png",
    "assets/icons/mstile-150x150.png",
    "assets/icons/safari-pinned-tab.svg"
]

var networkFirstFiles = ["./", "404.html", "offline.html", "sw.js", "manifest.json"]

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
