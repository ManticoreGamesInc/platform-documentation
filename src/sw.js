const filesToCache = [
    "/",
    "404.html",
    "assets/api/luacheckrc.zip",
    "assets/api/manticoreapi.lua",
    "assets/icons/CoreIcon_.png"
]

const staticCacheName = "pages-cache-v3"

self.addEventListener("install", event => {
    console.log("Attempting to install service worker and cache static assets")
    event.waitUntil(
        caches.open(staticCacheName).then(cache => {
            return cache.addAll(filesToCache)
        })
    )
})

self.addEventListener("fetch", event => {
    console.log("Fetch event for ", event.request.url)
    event.respondWith(
        caches
            .match(event.request)
            .then(response => {
                if (response) {
                    console.log("Found ", event.request.url, " in cache")
                    return response
                }
                console.log("Network request for ", event.request.url)
                return fetch(event.request).then(response => {
                    if (response.status === 404) {
                        return caches.match("404.html")
                    }
                    return caches.open(staticCacheName).then(cache => {
                        cache.put(event.request.url, response.clone())
                        return response
                    })
                })
            })
            .catch(error => {
                console.log("Error, ", error)
                return caches.match("offline.html")
            })
    )
})

self.addEventListener("activate", event => {
    console.log("Activating new service worker...")

    const cacheWhitelist = [staticCacheName]

    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.map(cacheName => {
                    if (cacheWhitelist.indexOf(cacheName) === -1) {
                        return caches.delete(cacheName)
                    }
                })
            )
        })
    )
})
