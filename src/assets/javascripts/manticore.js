/* eslint-disable no-unused-vars */

function addListenerMulti(element, eventNames, listener) {
  const events = eventNames.split(" ")
  for (let i = 0, iLen = events.length; i < iLen; i++) {
    element.addEventListener(events[i], listener, false)
  }
}

addListenerMulti(document, "DOMContentLoaded DOMContentSwitch", (event) => {
  // Add an icon to all external links
  const links = document.querySelectorAll(".md-content a")
  for (let i = 0, length = links.length; i < length; i++) {
    if (
      links[i].hostname !== window.location.hostname &&
      links[i].hostname !== "" &&
      links[i].classList.contains("md-icon") !== true &&
      links[i].classList.contains("download-button") !== true
    ) {
      links[i].target = "_blank"
      links[i].classList.add("external")
      links[i].rel = "noopener"
    }
  }
})

// Theme Toggle
const currentTheme = localStorage.getItem("theme")
const isDarkSchemePreferred = () =>
  window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches
const toggleSwitch = document.querySelector(
  ".theme-switch input[type='checkbox']"
)

if (currentTheme) {
  document.documentElement.setAttribute("data-theme", currentTheme)

  if (currentTheme === "dark") {
    localStorage.setItem("theme", "dark")
    toggleSwitch.checked = true
  }
} else {
  if (isDarkSchemePreferred()) {
    document.documentElement.setAttribute("data-theme", "dark")
    localStorage.setItem("theme", "dark")
    toggleSwitch.checked = true
  }
}

function switchTheme(e) {
  if (e.target.checked) {
    document.documentElement.setAttribute("data-theme", "dark")
    localStorage.setItem("theme", "dark")
  } else {
    document.documentElement.setAttribute("data-theme", "light")
    localStorage.setItem("theme", "light")
    toggleSwitch.checked = false
  }
}

toggleSwitch.addEventListener("change", switchTheme, false)
