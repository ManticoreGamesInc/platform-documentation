// Manticore JavaScript Helpers
document.addEventListener('DOMContentLoaded', (event) => {
    // scroll to top button
    var btn = document.getElementById("to-top-button")
    btn.addEventListener("click", function(e) {
        e.preventDefault()
        e.stopImmediatePropagation()
        window.scroll({ top: 0, left: 0, behavior: "smooth" })
    })

    // Add an icon to all external links
    var links = document.querySelectorAll( '.md-content a' );
    for (var i = 0, length = links.length; i < length; i++) {
        if (links[i].hostname != window.location.hostname && links[i].title != 'Edit this page' && links[i] != btn) {
            links[i].target = '_blank';
            links[i].className = 'external';
        }
    }

    // Load Videos in the Docs
    var elements = document.querySelectorAll('img[alt="YOUTUBE"]');
    var elementsLive = document.querySelectorAll('img[alt="YOUTUBELIVE"]');
    var elementsVimeo = document.querySelectorAll('img[alt="VIMEO"]');
    var elementsVimeoEvent = document.querySelectorAll('img[alt="VIMEOEVENT"]')

    Array.prototype.forEach.call(elements, function(el, i){
        var id = el.getAttribute('src').split('/')[el.getAttribute('src').split('/').length - 1];
        var old_class = el.getAttribute('class');
        var iframe = document.createElement('iframe');

        iframe.src = 'https://www.youtube.com/embed/' + id + '?modestbranding=1&amp;'

        if (old_class != 'null') {
            iframe.className = 'youtube-video ' + old_class
        } else {
            iframe.className = 'youtube-video'
        }

        el.replaceWith(iframe);
    });

    Array.prototype.forEach.call(elementsLive, function(el, i){
        var id = el.getAttribute('src').split('/')[el.getAttribute('src').split('/').length - 1];
        var old_class = el.getAttribute('class');
        var iframe = document.createElement('iframe');

        iframe.src = 'https://www.youtube.com/embed/live_stream?channel=' + id + '?modestbranding=1&amp;'

        if (old_class != 'null') {
            iframe.className = 'youtube-video ' + old_class
        } else {
            iframe.className = 'youtube-video'
        }

        el.replaceWith(iframe);
    });

    Array.prototype.forEach.call(elementsVimeo, function(el, i) {
        var id = el.getAttribute("src").split("/")[
            el.getAttribute("src").split("/").length - 1
        ]
        var old_class = el.getAttribute("class")
        var iframe = document.createElement("iframe")

        iframe.src =
            "https://player.vimeo.com/video/" + id

        if (old_class != "null") {
            iframe.className = "youtube-video " + old_class
        } else {
            iframe.className = "youtube-video"
        }

        el.replaceWith(iframe)
    })

    Array.prototype.forEach.call(elementsVimeoEvent, function(el, i) {
        var id = el.getAttribute("src").split("/")[
            el.getAttribute("src").split("/").length - 1
        ]
        var old_class = el.getAttribute("class")
        var iframe = document.createElement("iframe")

        iframe.src = "https://vimeo.com/event/" + id + "/embed"

        if (old_class != "null") {
            iframe.className = "youtube-video " + old_class
        } else {
            iframe.className = "youtube-video"
        }

        el.replaceWith(iframe)
    })

    // Change browser tab title based on header title near scroll position

    window.addEventListener('scroll', function(event) {
        var y_pos = window.pageYOffset || document.documentElement.scrollTop;
        var current_title = document.title;
        var headerlinks = document.getElementsByClassName('headerlink');

        if (document.documentElement.scrollTop > 300) {
            btn.classList.add("show")
        } else {
            btn.classList.remove("show")
        }

        Array.prototype.forEach.call(headerlinks, function(el, i) {
            var rect = el.getBoundingClientRect();
            if (y_pos > rect.top + document.documentElement.scrollTop - 90) {
                current_title = el.parentElement.textContent. slice(0, -1);
            }
        });

        document.title = current_title;
    });
})

// Dark mode detection
!function() {
	const darkMode = document.getElementById('dark-mode-toggle');

	if (darkMode) {
		const isDarkSchemePreferred = () => window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;

		darkMode.addEventListener('click', function(e) {
			e.preventDefault();
			e.stopImmediatePropagation();

			const isDark = document.documentElement.classList.contains('dark-mode') ? 0 : 1;

			this.href = '?dark=' + (1 - isDark);

			// If prefers-color-scheme is dark, and user disables dark mode, we need to keep the local storage as dark-mode = 0
            document.documentElement.classList.toggle('dark-mode', isDark);
            localStorage.setItem('dark-mode', isDark)
		});

		if (isDarkSchemePreferred() && localStorage.getItem('dark-mode') === null) {
            darkMode.click();
		}
	}
}();

// Enable lightgallery
let elements = document.getElementsByClassName('lightgallery')
for (let i = 0; i < elements.length; i++) {
  lightGallery(elements[i])
}
