// Load Videos in the Docs

document.addEventListener('DOMContentLoaded', (event) => {
    var elements = document.querySelectorAll('img[alt="YOUTUBE"]');

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

    var elementsLive = document.querySelectorAll('img[alt="YOUTUBELIVE"]');

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
})

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

		if (isDarkSchemePreferred() && localStorage.getItem('dark-mode') === -1) {
		    darkMode.click();
		}
	}
}();

let elements = document.getElementsByClassName("lightgallery")
for (let i = 0; i < elements.length; i++) {
  lightGallery(elements[i])
}


var links = document.querySelectorAll( '.md-content a' );
for (var i = 0, length = links.length; i < length; i++) {
    if (links[i].hostname != window.location.hostname && links[i].title != "Edit this page") {
        links[i].target = '_blank';
        links[i].className = "external";
    }
}
