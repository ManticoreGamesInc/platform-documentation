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
