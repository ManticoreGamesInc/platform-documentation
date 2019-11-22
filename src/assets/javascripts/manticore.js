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
})

!function() {
    const darkMode = document.getElementById("dark-mode-toggle");
    if (darkMode) {
        const isDarkSchemePreferred = ()=>window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches
          , toggleDarkMode = isDark=>{
            darkMode.href = "?dark=" + (1 - isDark),
            document.documentElement.classList.toggle("dark-mode", isDark),
            document.cookie = "__Host-dark=" + isDark + "; path=/; secure; samesite=lax; max-age=" + (isDark || isDarkSchemePreferred() ? "7776000" : "0")
        }
        ;
        darkMode.addEventListener("click", e=>{
            e.preventDefault();
            const isDark = document.documentElement.classList.contains("dark-mode") ? 0 : 1;
            toggleDarkMode(isDark)
        }
        ),
        isDarkSchemePreferred() && -1 === document.cookie.indexOf("__Host-dark=") && toggleDarkMode(1)
    }
}();
